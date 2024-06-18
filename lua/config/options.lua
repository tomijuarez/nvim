-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Disable mouse mode
vim.o.mouse = ""

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

--vim.cmd()
vim.opt.clipboard = "unnamedplus"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Concealer for Neorg
vim.o.conceallevel=2

-- [[ Basic Keymaps ]]
-- Set <,> as the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ","
vim.g.maplocalleader = ","


vim.opt.tabstop = 4  -- Número de espacios que representa un tab
vim.opt.shiftwidth = 4  -- Número de espacios para la indentación automática
vim.opt.expandtab = true  -- Usar espacios en lugar de tabs al presionar Tab
