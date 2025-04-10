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

-- Text wrap configuration
vim.opt.wrap = true               -- Enable line wrapping
vim.opt.breakindent = true        -- Preserve indentation in wrapped text
vim.opt.linebreak = true          -- Wrap at word boundaries
vim.opt.showbreak = '↪ '          -- Show character at wrap point
vim.opt.textwidth = 80            -- Maximum line length
vim.opt.whichwrap:append("<,>,[,]") -- Allow wrap when using arrow keys
vim.opt.display:append("lastline")   -- Show as much as possible of last line
vim.opt.formatoptions:append("l")    -- Long lines are not broken in insert mode
vim.opt.breakindentopt = "shift:2"   -- Shift wrapped lines for better readability
