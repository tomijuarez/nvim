return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
      local telescope = require("telescope")
      telescope.load_extension("git_worktree")
      telescope.load_extension("harpoon")
      telescope.load_extension("fzf")

      telescope.setup {
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              size = {
                width = "95%",
                height = "95%",
              },
            },
          },
          pickers = {
            find_files = {
              theme = "dropdown",
            }
          },
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ["<C-d>"] = require("telescope.actions").move_selection_previous,
            },
          },
        },
      }
    end
  },
  {"nvim-telescope/telescope-symbols.nvim"},
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = vim.fn.executable "make" == 1
  },
}
