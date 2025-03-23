require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!

local lsp_vim = vim.lsp
lsp_vim.set_log_level("off")

vim.api.nvim_set_hl(0, "IblChar", { fg = "#5c6370" }) -- Sesuaikan warna sesuai preferensi Anda
vim.api.nvim_set_hl(0, "IblScopeChar", { fg = "#61afef" }) -- Sesuaikan warna sesuai preferensi Anda
