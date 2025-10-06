-- Enable bytecode cache untuk startup time yang lebih cepat
vim.loader.enable()

vim.cmd [[
  syntax enable
  syntax on
]]

-- Setup lazy loading untuk fitur builtin
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

-- Performance settings
vim.opt.shadafile = "NONE"
vim.opt.history = 100
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 240
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.redrawtime = 1500
vim.opt.ttimeoutlen = 10
vim.opt.ttyfast = true

-- Cache paths
vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.termguicolors = true

-- Modified theme cache rebuilding logic
local present, base46 = pcall(require, "base46")
if not present then
  vim.notify("Base46 not found. Installing...", vim.log.levels.INFO)
  local base46_path = vim.g.base46_cache
  if vim.fn.empty(vim.fn.glob(base46_path)) > 0 then
    vim.fn.system {
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/NvChad/base46",
      base46_path,
    }
    vim.cmd "redraw!"
    vim.notify("Theme cache rebuilt! Please restart Neovim.", vim.log.levels.INFO)
  end
end

-- Package management prioritization
vim.g.did_load_filetypes = 1
vim.g.do_filetype_lua = 1

-- Optimize runtimepath
vim.opt.runtimepath:remove "/etc/xdg/nvim"
vim.opt.runtimepath:remove "/etc/xdg/nvim/after"
vim.opt.runtimepath:remove "/usr/share/vim/vimfiles"

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim configuration and setup plugins
local ok, lazy_config = pcall(require, "configs.lazy")
if not ok then
  vim.notify("configs.lazy not found, skipping lazy.setup()", vim.log.levels.WARN)
else
  require("lazy").setup(lazy_config)
end

-- Setup core (keep after lazy setup so plugins can be available if needed)
require "core.options"
require "core.keymaps"
require "core.autocmds"

-- Load base46 theme and statusline
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- Load custom autocommands
require "nvchad.autocmds"
require "configs.autocmds"

-- Schedule mappings to load after startup
vim.schedule(function()
  require "mappings"
end)
