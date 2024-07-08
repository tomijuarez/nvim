vim.api.nvim_create_autocmd("FileType", {
    pattern = "*.sh",
    callback = function()
      vim.lsp.start({
        name = "bash-language-server",
        cmd = { "bash-language-server", "start" },
      })
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.java",
  callback = function()
    vim.lsp.buf.code_action {
      apply = true,
      context = {
        only = {"source.organizeImports"}
      }
    }
  end,
})

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require("go.format").goimport()
  end,
  group = format_sync_grp,
})

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.template",
  command = "setfiletype yaml",
})

-- hack para que noice muestre bordes transparentes en popupmenu
vim.cmd [[
    hi NormalFloat guibg=NONE ctermbg=NONE
    hi FloatBorder guibg=NONE guifg=#5c6370 ctermbg=NONE ctermfg=8
]]
