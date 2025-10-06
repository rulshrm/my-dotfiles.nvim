-- Sensible defaults
local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.updatetime = 300
opt.timeoutlen = 400
opt.wrap = false
opt.scrolloff = 6
opt.sidescrolloff = 6

-- Completion UI behavior (important for cmp)
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 12

-- Tabs/indent
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- Split behavior
opt.splitright = true
opt.splitbelow = true
