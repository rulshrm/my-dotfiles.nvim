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

-- Performance
vim.opt.hidden = true         -- Enable background buffers
vim.opt.history = 100        -- Reduce history size
vim.opt.lazyredraw = true    -- Don't redraw while executing macros
vim.opt.synmaxcol = 240      -- Max column for syntax highlight
vim.opt.updatetime = 250     -- Decrease update time
vim.opt.timeoutlen = 300     -- Decrease timeout length
vim.opt.redrawtime = 1500    -- Time limit for syntax highlighting
vim.opt.ttimeoutlen = 10     -- Reduce key code delay
vim.opt.ttyfast = true       -- Faster terminal connection

-- Disable unused built-in plugins
local disabled_built_ins = {
  "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
  "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
  "getscript", "getscriptPlugin", "vimball", "vimballPlugin",
  "2html_plugin", "logipat", "rrhelper", "spellfile_plugin", "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
