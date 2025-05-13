-- Enable bytecode cache to improve startup time
vim.loader.enable()

-- Set base46 cache path and leader key
vim.g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.termguicolors = true

-- Modified theme cache rebuilding logic
local present, base46 = pcall(require, "base46")
if not present then
  vim.notify("Base46 not found. Installing...", vim.log.levels.INFO)
  local base46_path = vim.g.base46_cache
  if vim.fn.empty(vim.fn.glob(base46_path)) > 0 then
    vim.fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/NvChad/base46",
      base46_path,
    })
    vim.cmd("redraw!")
    vim.notify("Theme cache rebuilt! Please restart Neovim.", vim.log.levels.INFO)
  end
end

-- Package management prioritization
vim.g.did_load_filetypes = 1
vim.g.do_filetype_lua = 1

-- Optimize runtimepath
vim.opt.runtimepath:remove("/etc/xdg/nvim")
vim.opt.runtimepath:remove("/etc/xdg/nvim/after")
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim configuration
local lazy_config = require("configs.lazy")

-- Setup plugins using lazy.nvim
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require("options")
    end,
  },
  { import = "plugins" },
}, lazy_config)

-- Load base46 theme and statusline
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- Load custom autocommands
require("nvchad.autocmds")
require("configs.autocmds")

-- Schedule mappings to load after startup
vim.schedule(function()
  require("mappings")
end)
