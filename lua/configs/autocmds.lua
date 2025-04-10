-- -- Format file secara otomatis sebelum menyimpan menggunakan prettierd
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.css", "*.html", "*.yaml", "*.md" },
--   callback = function()
--     local file = vim.fn.expand("%:p") -- Dapatkan path file saat ini
--     if vim.fn.filereadable(file) == 0 then
--       vim.notify("File not readable: " .. file, vim.log.levels.ERROR)
--       return
--     end

--     local cmd = string.format("prettierd %s", file)
--     local result = vim.fn.system(cmd)

--     if vim.v.shell_error ~= 0 then
--       vim.notify("Prettierd failed: " .. result, vim.log.levels.ERROR)
--     else
--       vim.notify("File formatted with Prettierd", vim.log.levels.INFO)
--     end
--   end,
-- })
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.css", "*.html", "*.yaml", "*.md" },
  callback = function()
    vim.lsp.buf.format({
      async = false,
      filter = function(client)
        return client.name == "null-ls"
      end,
    })
  end,
})

-- Reload file secara otomatis jika diubah di luar Neovim
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.cmd("echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "text", "html", "xml" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
    end,
})