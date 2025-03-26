-- Format file secara otomatis sebelum menyimpan
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local conform = require("conform")
    local success = conform.format({ async = true })
    if not success then
      vim.lsp.buf.format { async = true }
    end
  end,
})

-- Reload file secara otomatis jika diubah di luar Neovim
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.cmd("echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None")
  end,
})