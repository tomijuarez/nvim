return {
    {"nvim-treesitter/nvim-treesitter-context"}, -- header con contexto del archivo actual
    {"onsails/lspkind.nvim"}, -- dropdown con simbolos reconocidos por el LSP
    { -- preview de markdown
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
      "kkharji/lspsaga.nvim",
      config = function ()
        require("lspsaga").setup{}
      end
    },
    { -- terminal flotante 
        "numToStr/FTerm.nvim",
        config = function()
            require("FTerm").setup({
              border = "rounded",
              blend = 0,
              dimensions = {
                height = 0.5,
                width = 0.7,
                x = 0.5,
                y = 0.5
              }
            })
        end
    },
    { -- preview de codigo en ventana flotante
        "rmagatti/goto-preview",
        config = function()
          require("goto-preview").setup {
            width = 120; -- Width of the floating window
            height = 15; -- Height of the floating window
            border = {"↖", "─" ,"┐", "│", "┘", "─", "└", "│"}; -- Border characters of the floating window
            default_mappings = true;
            debug = false; -- Print debug information
            opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
            resizing_mappings = false; -- Binds arrow keys to resizing the floating window.
            post_open_hook = nil; -- A function taking two arguments, a buffer and a window to be ran as a hook.
            references = { -- Configure the telescope UI for slowing the references cycling window.
              telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
            };
            -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
            focus_on_open = true; -- Focus the floating window when opening it.
            dismiss_on_move = false; -- Dismiss the floating window when moving the cursor.
            force_close = true, -- passed into vim.api.nvim_win_close"s second argument. See :h nvim_win_close
            bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
            stack_floating_preview_windows = true, -- Whether to nest floating windows
            preview_window_title = { enable = true, position = "left" }, -- Whether 
          }
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup {
                options = {
                  icons_enabled = true,
                  component_separators = "|",
                  section_separators = "",
                },
                sections = {
                  lualine_x = {
                    {
                      require("noice").api.statusline.mode.get,
                      cond = require("noice").api.statusline.mode.has,
                      color = { fg = "#ff9e64" },
                    },
                    {
                      require("noice").api.status.command.get,
                      cond = require("noice").api.status.command.has,
                      color = { fg = "#ff9e64" },
                    },
                  },
                  lualine_a = {
                    {
                      "buffers",
                    }
                  }
                }
            }              
        end
    },
    {
      "rcarriga/nvim-notify",
      config = function()
        require("notify").setup{}
      end
    },
    {
      "folke/noice.nvim",
      config = function()
        require("noice").setup({
          popupmenu = {
            backend = "nui",
            kind_icons = true,
            transparency = 20,
            border = {
              style = "rounded",
              text = {
                top = "",
                top_align = "center",
              },
            },
          },
          routes = {
            {
              filter = {
                event = "msg_show",
                any = {
                  { find = "%d+L, %d+B" },
                  { find = "; after #%d+" },
                  { find = "; before #%d+" },
                  { find = "%d fewer lines" },
                  { find = "%d more lines" },
                },
              },
              opts = { skip = true },
            }
          },
        })
      end,
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      }
    },
    {
      "stevearc/oil.nvim",
      config = function ()
        require("oil").setup()
      end
    }
}
