-- filepath: ~/.config/nvim/lua/plugins/init.lua
return {
  -- Import semua plugin berdasarkan kategori
  { import = "plugins.lsp" },      -- LSP related plugins
  { import = "plugins.completion" }, -- Completion related plugins
  { import = "plugins.coding" },    -- Coding tools
  { import = "plugins.editor" },    -- Editor enhancements
  { import = "plugins.ui" },        -- UI components
  { import = "plugins.utils" },     -- Utilities
}
