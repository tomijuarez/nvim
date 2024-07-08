return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = function()
      pcall(require("nvim-treesitter.install").update { with_sync = true })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function ()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "go",
          "lua",
          "python",
          "rust",
          "typescript",
          "regex",
          "bash",
          "markdown",
          "markdown_inline",
          "kdl",
          "sql",
          "org",
          "terraform",
          "html",
          "css",
          "javascript",
          "yaml",
          "json",
          "toml",
          "java"
        },

        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-a>",
            node_decremental = "<c-backspace>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["po"] = "@parameter.outer",
              ["pi"] = "@parameter.inner",
              ["f"] = "@function.outer",
              ["fi"] = "@function.inner",
              ["c"] = "@class.outer",
              ["ci"] = "@class.inner",
              ["i"] = "@conditional.inner",
              ["io"] = "@conditional.outer",
              ["l"] = "@loop.inner",
              ["lo"] = "@loop.outer",
              ["cc"] = "@comment.outer",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["c-nf"] = "@function.outer",
              ["c-nc"] = "@class.outer",
            },
            goto_next_end = {
              ["c-nfe"] = "@function.outer",
              ["c-nce"] = "@class.outer",
            },
            goto_previous_start = {
              ["c-pf"] = "@function.outer",
              ["c-pc"] = "@class.outer",
            },
            goto_previous_end = {
              ["c-pfe"] = "@function.outer",
              ["c-pce"] = "@class.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
        },
      }
    end
  },
}
