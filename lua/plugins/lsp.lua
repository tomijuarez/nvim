-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = "Format current buffer with LSP" })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- esto muestra el status abajo a la derecha con fondo negro
      "j-hui/fidget.nvim",
    },
    config = function()
      -- Setup mason so it can manage external tooling
      require("mason").setup()

      -- Enable the following language servers
      -- Feel free to add/remove any LSPs that you want here. They will automatically be installed
      local servers = { "clangd", "rust_analyzer", "pyright", "tsserver", "gopls", "jdtls", "bashls"}

      -- Ensure the servers above are installed
      require("mason-lspconfig").setup {
        ensure_installed = servers,
      }

      -- nvim-cmp supports additional completion capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      for _, lsp in ipairs(servers) do
        require("lspconfig")[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end

      -- Turn on lsp status information
      require("fidget").setup()

      -- Example custom configuration for lua
      --
      -- Make runtime files discoverable to the server
      local runtime_path = vim.split(package.path, ";")
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      require("lspconfig").lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you"re using (most likely LuaJIT)
              version = "LuaJIT",
              -- Setup your lua path
              path = runtime_path,
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false },
          },
        },
      }
    end
  },
  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    config = function()
      -- nvim-cmp setup
      local cmp = require "cmp"
      local luasnip = require "luasnip"

      cmp.setup {
        view = {
          entries = "native"
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "neorg" },
        },
      }
    end
  },
  {
    "mfussenegger/nvim-jdtls",
    config = function()
      -- JAVA LSP
      local jdtls_setup = require("jdtls.setup")
      local home = os.getenv("HOME")

      local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
      local root_dir = jdtls_setup.find_root(root_markers)

      local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
      project_name = project_name:gsub("[^%w]", "_") -- Reemplaza caracteres no válidos por guiones bajos
      local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name
      local path_to_mason_packages = home .. "/.local/share/nvim/mason/packages"
      local path_to_jdtls = path_to_mason_packages .. "/jdtls"
      local path_to_jdebug = path_to_mason_packages .. "/java-debug-adapter"
      local path_to_jtest = path_to_mason_packages .. "/java-test"
      local path_to_config = path_to_jdtls .. "/config_mac_arm"
      local lombok_path = home .. "/dev/libs/lombok.jar"
      local path_to_jar = path_to_jdtls .. "/plugins/org.eclipse.equinox.launcher_1.6.800.v20240330-1250.jar"

      local bundles = {
        vim.fn.glob(path_to_jdebug .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
      }

      vim.list_extend(bundles, vim.split(vim.fn.glob(path_to_jtest .. "/extension/server/*.jar", true), "\n"))

      local cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "-javaagent:" .. lombok_path,
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        path_to_jar,
        "-configuration",
        path_to_config,
        "-data",
        workspace_dir,
      }

      require("lspconfig").jdtls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        extendedClientCapabilities = {
          advancedOrganizeImportsSupport = false;
        },
        cmd = cmd,
        filetypes = { "java" },
        settings = {
          java = {
            contentProvider = { preferred = "workspace" },
            references = {
              includeDecompiledSources = true,
            },
            implementationsCodeLens = {
              enabled = false,
            },
            referenceCodeLens = {
              enabled = false,
            },
            inlayHints = {
              parameterNames = {
                  enabled = "none",
              },
            },
            signatureHelp = {
              enabled = true,
              description = {
                  enabled = true,
              },
            },
            eclipse = {
              downloadSources = true,
            },
            maven = {
              downloadSources = true,
            },
            completion = {
              imports = {
                enabled = true,
              },
              filteredTypes = {
                "com.sun.*",
                "io.micrometer.shaded.*",
                "java.awt.*",
                "jdk.*",
                "sun.*",
              },
              importOrder = {
                "java",
                "javax",
                "com",
                "org",
              }
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            codeGeneration = {
              toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
              },
              useBlocks = true,
            },
          },
        },
        handlers = {
          ["language/status"] = function(_, result)
            -- Print or whatever.
          end,
          ["$/progress"] = function(_, result, ctx)
            -- disable progress updates.
          end,
        },
      }
    end
  }
}
