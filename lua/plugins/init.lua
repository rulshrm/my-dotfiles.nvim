-- filepath: ~/.config/nvim/lua/plugins/init.lua

--[[
  Plugins entry point
  This file organizes all plugin imports by category
  Each category is in its own subdirectory under plugins/
--]]

return {
  -- Core dependencies
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
  },

  -- Plugin category imports
  { import = "plugins.lsp" },         -- LSP support
  { import = "plugins.completion" },   -- Autocompletion
  { import = "plugins.php" },         -- PHP Development
  { import = "plugins.coding" },      -- Code analysis tools
  { import = "plugins.editor" },      -- Editor features
  { import = "plugins.ui" },          -- UI components
  { import = "plugins.utils" },       -- Utility functions
  { import = "plugins.testing" },     -- Testing frameworks
  { import = "plugins.project" },     -- Project management
}
