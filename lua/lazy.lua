-- Bootstrap lazy.nvim & setup
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  spec = {
    { import = "plugins" }, -- auto-import semua module di lua/plugins
    { import = "plugins.completion" }, -- sub-folder
    { import = "plugins.lsp" },
    { import = "plugins.formatting" },
  },
  defaults = { lazy = true, version = false },
  install = { colorscheme = { "tokyonight", "catppuccin", "onedark" } },
  checker = { enabled = false },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "spellfile",
        "netrwPlugin",
        "matchparen",
      },
    },
  },
}
