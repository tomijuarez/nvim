vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("i", "jj", "<Esc>", {noremap=false})

-- buffers
vim.keymap.set("n", "tk", ":blast<enter>", {noremap=false})
vim.keymap.set("n", "tj", ":bfirst<enter>", {noremap=false})
vim.keymap.set("n", "th", ":bprev<enter>", {noremap=false})
vim.keymap.set("n", "tl", ":bnext<enter>", {noremap=false})
vim.keymap.set("n", "td", ":bdelete<enter>", {noremap=false})

-- files
vim.keymap.set("n", "QQ", ":q!<enter>", {noremap=false})
vim.keymap.set("n", "WW", ":w!<enter>", {noremap=false})
vim.keymap.set("n", "E", "$", {noremap=false})
vim.keymap.set("n", "B", "^", {noremap=false})
vim.keymap.set("n", "TT", ":TransparentToggle<CR>", {noremap=true})
vim.keymap.set("n", "ss", ":noh<CR>", {noremap=true})

-- splits
vim.keymap.set("n", "<C-W>,", ":vertical resize -10<CR>", {noremap=true})
vim.keymap.set("n", "<C-W>.", ":vertical resize +10<CR>", {noremap=true})
vim.keymap.set("n", "<space><space>", "<cmd>set nohlsearch<CR>")
-- Quicker close split
vim.keymap.set("n", "<leader>qq", ":q<CR>", {silent = true, noremap = true})


-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Noice
vim.keymap.set("n", "<leader>nd", ":Noice dismiss<CR>", {noremap=true})

-- telescope
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>/", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(
    require("telescope.themes").get_dropdown {
      winblend = 10,
      previewer = true,
    }
  )
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sb", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>sS", require("telescope.builtin").git_status, { desc = "" })
vim.keymap.set("n", "<leader>sm", ":Telescope harpoon marks<CR>", { desc = "Harpoon [M]arks" })
vim.keymap.set("n", "<Leader>sr", "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", {silent=true})
vim.keymap.set("n", "<Leader>sR", "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", {silent=true})
vim.keymap.set("n", "<Leader>sn", "<CMD>lua require('telescope').extensions.notify.notify()<CR>", {silent=true})

vim.keymap.set("n", "st", ":TodoTelescope<CR>", {noremap=true})
vim.keymap.set("n", "<Leader><tab>", "<Cmd>lua require('telescope.builtin').commands()<CR>", {noremap=false})

-- Debugging
vim.fn.sign_define("DapBreakpoint", { text="🔴", texthl="DapBreakpoint", linehl="DapBreakpoint", numhl="DapBreakpoint" })

vim.keymap.set("n", "<leader>dt", ":DapUiToggle<CR>", {noremap=true})
vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", {noremap=true})
vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>", {noremap=true})
vim.keymap.set("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", {noremap=true})

-- Harpoon
vim.keymap.set("n", "<leader>ht", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", {noremap=true})

-- Neogit
vim.keymap.set("n", "<leader>gs", require("neogit").open, {silent = true, noremap = true})
vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>gp", ":Neogit pull<CR>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>gP", ":Neogit push<CR>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>gB", ":G blame<CR>", {silent = true, noremap = true})

-- Harpoon
vim.keymap.set("n", "<leader>A", function() require("harpoon"):list():add() end, {desc = "harpoon file"})
vim.keymap.set("n", "<leader>ht", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "harpoon quick menu"})
vim.keymap.set("n", "<leader>1", function() require("harpoon"):list():select(1) end, {desc = "harpoon to file 1"})
vim.keymap.set("n", "<leader>2", function() require("harpoon"):list():select(2) end, {desc = "harpoon to file 2"})
vim.keymap.set("n", "<leader>3", function() require("harpoon"):list():select(3) end, {desc = "harpoon to file 3"})
vim.keymap.set("n", "<leader>4", function() require("harpoon"):list():select(4) end, {desc = "harpoon to file 4"})
vim.keymap.set("n", "<leader>5", function() require("harpoon"):list():select(5) end, {desc = "harpoon to file 5"})

-- diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- trouble
-- TODO: cambiar
vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",{silent = true, noremap = true})
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",{silent = true, noremap = true})
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",{silent = true, noremap = true})
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",{silent = true, noremap = true})
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",{silent = true, noremap = true})

-- FTerm
vim.keymap.set("n", '<leader>ft', "<CMD>lua require('FTerm').toggle()<CR>")
vim.keymap.set("t", '<leader>ft', "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>")