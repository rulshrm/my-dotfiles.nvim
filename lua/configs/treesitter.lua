-- ~/.config/nvim/lua/configs/treesitter.lua

return {
  -- Parsers to install
  ensure_installed = {
    "vim",          -- Vimscript
    "lua",          -- Lua
    "html",         -- HTML
    "css",          -- CSS
    "javascript",   -- JavaScript
    "typescript",   -- TypeScript
    "tsx",          -- React/TSX
    "json",         -- JSON
    "yaml",         -- YAML
    "markdown",     -- Markdown
    "bash",         -- Bash scripting
    "svelte",       -- Svelte
    "graphql",      -- GraphQL
    "scss",         -- SCSS
    "vue",          -- Vue
    "astro",        -- Astro
    "dockerfile",   -- Dockerfile
    "python",       -- Python
    "go",           -- Go
    "rust",         -- Rust
    "c",            -- C
    "cpp",          -- C++
  },

  highlight = {
    enable = true,              -- Enable syntax highlighting
    use_languagetree = true,    -- Use language tree for better performance
  },

  indent = {
    enable = true,              -- Enable indentation based on syntax
  },

  folding = {
    enable = true,              -- Enable code folding
    disable = {},               -- Disable folding for specific languages if needed
  },

  incremental_selection = {
    enable = true,              -- Enable incremental selection
    keymaps = {
      init_selection = "gnn",   -- Start selection
      node_incremental = "grn", -- Increment to the next node
      scope_incremental = "grc",-- Increment to the next scope
      node_decremental = "grm", -- Decrement to the previous node
    },
  },

  textobjects = {
    select = {
      enable = true,            -- Enable textobjects
      lookahead = true,         -- Automatically jump forward to textobj
      keymaps = {
        ["af"] = "@function.outer", -- Select around a function
        ["if"] = "@function.inner", -- Select inside a function
        ["ac"] = "@class.outer",    -- Select around a class
        ["ic"] = "@class.inner",    -- Select inside a class
      },
    },
move = {
      enable = true,            -- Enable moving between textobjects
      set_jumps = true,         -- Set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer", -- Go to next function start
        ["]c"] = "@class.outer",    -- Go to next class start
      },
      goto_previous_start = {
        ["[m"] = "@function.outer", -- Go to previous function start
        ["[c"] = "@class.outer",    -- Go to previous class start
      },
    },
  },
}
