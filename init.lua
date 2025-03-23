-- Set base46 cache path and leader key
vim.g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"
vim.g.mapleader = " "

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
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "│", highlight = "IblChar" },
      scope = { char = "│", highlight = "IblScopeChar" },
    },
    config = function(_, opts)
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require "configs.dap"
    end,
  },
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.g.copilot_no_tab_map = true -- Nonaktifkan pemetaan default untuk <Tab>
      vim.g.copilot_enable_suggestions = true -- Aktifkan saran Copilot
      vim.g.copilot_assume_mapped = true -- Beritahu Copilot bahwa tombol sudah dipetakan
      vim.g.copilot_filetypes = {
        ["*"] = true, -- Aktifkan untuk semua filetype
        ["markdown"] = true, -- Aktifkan untuk Markdown
        ["lua"] = true, -- Aktifkan untuk Lua
        ["javascript"] = true, -- Aktifkan untuk JavaScript
        ["typescript"] = true, -- Aktifkan untuk TypeScript
        ["html"] = true, -- Aktifkan untuk HTML
        ["css"] = true, -- Aktifkan untuk CSS
      }
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "github/copilot.vim" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}, lazy_config)

-- Load base46 theme and statusline
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- Load custom autocommands
require("nvchad.autocmds")

-- Schedule mappings to load after startup
vim.schedule(function()
  require("mappings")
end)
