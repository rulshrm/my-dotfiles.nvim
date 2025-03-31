-- Format file secara otomatis sebelum menyimpan
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local conform = require("conform")
    local ft = vim.bo.filetype

    -- Periksa apakah ada formatter yang terdaftar untuk filetype ini
    local formatters = conform.list_formatters(ft)
    if #formatters == 0 then
      vim.notify("No formatter configured for filetype: " .. ft, vim.log.levels.WARN)
      return
    end

    -- Jalankan formatter
    local success = conform.format({ async = true })
    if not success then
      vim.notify("Conform failed to format the file. Falling back to LSP.", vim.log.levels.WARN)
      vim.lsp.buf.format { async = true }
    else
      vim.notify("Conform successfully formatted the file.", vim.log.levels.INFO)
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