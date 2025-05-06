local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Nonaktifkan provider yang tidak digunakan
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Create augroups once
local format_group = augroup("FormatGroup", { clear = true })
local general_group = augroup("GeneralGroup", { clear = true })

-- Format on save with debounce
autocmd("BufWritePre", {
  group = format_group,
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.css", "*.html", "*.yaml", "*.md" },
  callback = function()
    require("conform").format({
      async = false,
      timeout_ms = 2000,
      lsp_fallback = true,
    })
  end,
})

-- Optimize file reload
autocmd("FocusGained", {
  group = general_group,
  command = "checktime",
})

-- Reload file secara otomatis jika diubah di luar Neovim
autocmd("FileChangedShellPost", {
  group = general_group,
  pattern = "*",
  callback = function()
    vim.cmd("echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None")
  end,
})

autocmd("FileType", {
  group = general_group,
  pattern = { "markdown", "text", "html", "xml" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
  end,
})