-- Enable bytecode cache to improve startup time
vim.loader.enable()

-- Set base46 cache path and leader key
vim.g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.termguicolors = true

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
