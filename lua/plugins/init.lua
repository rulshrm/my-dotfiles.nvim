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

  -- Group plugins berdasarkan event/command
  { import = "plugins.lsp", event = { "BufReadPre", "BufNewFile" } },
  { import = "plugins.completion", event = "InsertEnter" },
  { import = "plugins.ui", event = "VeryLazy" },
  { import = "plugins.coding", event = { "BufReadPre", "BufNewFile" } },
  { import = "plugins.utils", event = "VeryLazy" },
}
