-- filepath: ~/.config/nvim/lua/plugins/init.lua

--[[
  Plugins entry point
  This file organizes all plugin imports by category
  Each category is in its own subdirectory under plugins/
--]]

return {
  -- Core plugins dengan lazy = false untuk load saat startup
  {
    "nvim-lua/plenary.nvim",
    lazy = false, -- Required by many plugins, load immediately
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
  },

  -- Plugins yang bisa di-lazy load
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    }
  },

  -- PHP/Laravel Development
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-dotenv",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Artisan", "Composer" },
    keys = {
      { "<leader>la", ":Artisan<cr>" },
      { "<leader>lr", ":Artisan route:list<cr>" },
      { "<leader>lm", ":Artisan make:" },
      { "<leader>lt", ":Artisan tinker<cr>" },
    },
    config = function()
      require("laravel").setup()
    end,
  },
  {
    "jwalton512/vim-blade",
    ft = "blade",
  },
  {
    "tpope/vim-dispatch",
    cmd = { "Dispatch", "Make" },
  },
  {
    "noahfrederick/vim-composer",
    dependencies = { "tpope/vim-dispatch" },
    ft = "php",
  },

  -- Group plugins berdasarkan event/command
  { import = "plugins.lsp", event = { "BufReadPre", "BufNewFile" } },
  { import = "plugins.completion", event = "InsertEnter" },
  { import = "plugins.ui", event = "VeryLazy" },
  { import = "plugins.coding", event = { "BufReadPre", "BufNewFile" } },
  { import = "plugins.utils", event = "VeryLazy" },
}
