require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!

local lsp_vim = vim.lsp
lsp_vim.set_log_level("off")

vim.api.nvim_set_hl(0, "IblChar", { fg = "#5c6370" }) -- Sesuaikan warna sesuai preferensi Anda
vim.api.nvim_set_hl(0, "IblScopeChar", { fg = "#61afef" }) -- Sesuaikan warna sesuai preferensi Anda

-- Highlight untuk import-cost.nvim
vim.api.nvim_set_hl(0, "ImportCostSmall", { fg = "#A3BE8C", bg = "NONE" }) -- Warna hijau untuk ukuran kecil
vim.api.nvim_set_hl(0, "ImportCostMedium", { fg = "#EBCB8B", bg = "NONE" }) -- Warna kuning untuk ukuran sedang
vim.api.nvim_set_hl(0, "ImportCostLarge", { fg = "#BF616A", bg = "NONE" }) -- Warna merah untuk ukuran besar
