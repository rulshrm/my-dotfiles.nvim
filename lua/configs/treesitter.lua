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
    "php",          -- PHP
    "blade",        -- Blade templates
  },  -- Install only what you need

  sync_install = false,        -- Install parsers asynchronously
  auto_install = false,        -- Disable automatic installation

  highlight = {
    enable = true,              -- Enable syntax highlighting
    disable = function(_, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    use_languagetree = true,    -- Use language tree for better performance
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,              -- Enable indentation based on syntax
  },

  autotag = {
    enable = true,              -- Enable autotagging
    filetypes = {
      'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 
      'svelte', 'vue', 'tsx', 'jsx', 'rescript', 'xml',
      'php', 'markdown', 'astro', 'glimmer', 'handlebars', 'hbs'
    },
  },

  context_commentstring = {
    enable = true,              -- Enable context comment string
    enable_autocmd = false,     -- Disable automatic commands
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
