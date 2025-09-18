require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt = 'both'

local lsp_vim = vim.lsp
lsp_vim.set_log_level("off")

-- Show hidden files
vim.opt.hidden = true

-- Set higher max file size for reading
vim.opt.maxmempattern = 2000000  -- 2MB

-- Show all files including dotfiles
vim.g.nvim_tree_show_hidden = 1
vim.g.nvim_tree_hide_dotfiles = 0

-- Enable dot file detection
vim.g.show_hidden = true

-- Enable .env file detection
vim.g.dotenv_pattern = '.env*'

-- Add .env to recognized file types
vim.filetype.add({
  pattern = {
    ['.env.*'] = 'dotenv',
    ['.env'] = 'dotenv',
  },
})

-- Configure list chars for better visualization
vim.opt.list = true
vim.opt.listchars = {
  tab = '→ ',
  eol = '↵',
  trail = '•',
  extends = '❯',
  precedes = '❮',
}

-- highlight untuk hlchunk
vim.api.nvim_set_hl(0, "HlchunkIndent", { fg = "#2d3343" })
vim.api.nvim_set_hl(0, "HlchunkScope", { fg = "#61afef" })

-- Highlight untuk import-cost.nvim
vim.api.nvim_set_hl(0, "ImportCostSmall", { fg = "#98c379", bold = true })
vim.api.nvim_set_hl(0, "ImportCostMedium", { fg = "#e5c07b", bold = true })
vim.api.nvim_set_hl(0, "ImportCostLarge", { fg = "#e06c75", bold = true })

-- Icon dan folder highlights
vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#4FC1FF" })
vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#4FC1FF" })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#9CDCFE", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", { fg = "#4FC1FF", italic = true })
vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#3b4261" })
vim.api.nvim_set_hl(0, "NvimTreeSymlinkFolderName", { fg = "#7FDBCA" })

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

-- Cache filesystem operations
vim.opt.directory = vim.fn.stdpath("data") .. "/swap/"
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo/"
vim.opt.backupdir = vim.fn.stdpath("data") .. "/backup/"

-- Create directories if they don't exist
for _, dir in ipairs({ "swap", "undo", "backup" }) do
  local path = vim.fn.stdpath("data") .. "/" .. dir
  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, "p")
  end
end

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

vim.g.matchup_matchparen_offscreen = { method = "popup" }
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- Menonaktifkan folding saat startup untuk performa
vim.opt.foldenable = false

vim.opt.termguicolors = true
