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
    lazy = false, -- Required by many plugins, load immediately
  },

  -- Plugin category imports
  { import = "plugins.lsp" },         -- Language Server Protocol support
  { import = "plugins.completion" },   -- Autocompletion and snippets
  { import = "plugins.coding" },       -- Code analysis and refactoring tools  
  { import = "plugins.editor" },       -- Editor features and enhancements
  { import = "plugins.ui" },           -- User interface components
  { import = "plugins.utils" },        -- Utility functions and helpers
  { import = "plugins.testing" },      -- Testing frameworks integration
  { import = "plugins.project" },      -- Project management features
  { import = "plugins.typescript" },   -- TypeScript specific tooling
  { import = "plugins.docs" },         -- Documentation generators
}
