require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!

local lsp_vim = vim.lsp
lsp_vim.set_log_level("off")

vim.api.nvim_set_hl(0, "IblChar", { fg = "#5c6370" }) -- Sesuaikan warna sesuai preferensi Anda
vim.api.nvim_set_hl(0, "IblScopeChar", { fg = "#61afef" }) -- Sesuaikan warna sesuai preferensi Anda

-- Highlight untuk import-cost.nvim
vim.api.nvim_set_hl(0, "ImportCostSmall", { fg = "#98c379", bold = true }) -- Green
vim.api.nvim_set_hl(0, "ImportCostMedium", { fg = "#e5c07b", bold = true }) -- Yellow
vim.api.nvim_set_hl(0, "ImportCostLarge", { fg = "#e06c75", bold = true }) -- Red
