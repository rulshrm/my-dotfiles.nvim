-- filepath: ~/.config/nvim/lua/plugins/init.lua
return {
  -- Core plugin categories
  { import = "plugins.lsp" },        -- LSP related plugins
  { import = "plugins.completion" },  -- Completion related plugins
  { import = "plugins.coding" },      -- Coding tools
  { import = "plugins.editor" },      -- Editor enhancements
  { import = "plugins.ui" },          -- UI components
  { import = "plugins.utils" },       -- Utilities
  { import = "plugins.testing" },     -- Testing plugins
  { import = "plugins.project" },     -- Project management
  { import = "plugins.typescript" },  -- TypeScript specific
  { import = "plugins.docs" },        -- Documentation plugins
}
