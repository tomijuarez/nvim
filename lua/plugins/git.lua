return {
    {"tpope/vim-fugitive"},
    {
      "lewis6991/gitsigns.nvim",
      config = function ()
        require("gitsigns").setup {
          signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
          },
          current_line_blame = false,
          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
        
            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end
        
            -- Navigation
            map("n", "]c", function()
              if vim.wo.diff then return "]c" end
              vim.schedule(function() gs.next_hunk() end)
              return "<Ignore>"
            end, {expr=true})
        
            map("n", "[c", function()
              if vim.wo.diff then return "[c" end
              vim.schedule(function() gs.prev_hunk() end)
              return "<Ignore>"
            end, {expr=true})

            -- Text object
            map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
          end
        }        
      end
    },
    {
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
      },
      config = function ()
        require("neogit").setup {}    
      end
    },
    {
      "ThePrimeagen/git-worktree.nvim",
      config = function ()
        -- worktree settings
        require("git-worktree").setup()
      end
    }
}
