-- ~/.config/nvim/lua/plugins/init.lua
return {
  -- Formatting and linting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- Format on save
    config = function()
      require "configs.conform" -- Memuat konfigurasi utama untuk Conform
      require "configs.mason-conform" -- Memastikan formatter diinstal
    end,
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  -- Mason for managing LSP servers, formatters, and linters
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSPs
        "lua-language-server", -- Lua LSP
        "html-lsp",            -- HTML LSP
        "css-lsp",             -- CSS LSP
        "typescript-language-server", -- TypeScript/JavaScript LSP
        "json-languageserver", -- JSON LSP
        "yaml-language-server", -- YAML LSP
        "vimls",               -- Vimscript LSP
        "rust_analyzer",       -- Rust LSP
        "gopls",               -- Go LSP
        "nimls",               -- Nim LSP

        -- Formatters
        "prettier",            -- Prettier for formatting
        "prettierd",           -- Prettier daemon
        "stylua",              -- Lua formatter
        "rustfmt",             -- Rust formatter
        "google-java-format",  -- Java formatter
        "clang-format",        -- C/C++ formatter
        "alejandra",           -- Nix formatter
        "nixpkgs-fmt",         -- Nix formatter
        "fish_indent",         -- Fish shell formatter

        -- Linters
        "eslint_d",            -- ESLint daemon for JS/TS
        "ruff",                -- Python linter/formatter
      },
    },
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      return require "nvchad.configs.gitsigns"
    end,
  },

  -- Highlight code chunks
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.chunk"
    end,
  },

  -- Wakatime integration
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },

  -- File icons
  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      dofile(vim.g.base46_cache .. "devicons")
      return { override = require "nvchad.icons.devicons" }
    end,
  },

  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      indent = { char = "│", highlight = "IblChar" },
      -- scope = { char = "│", highlight = "IblScopeChar" },
    },
    config = function(_, opts)
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)
    end,
  },

  -- Inline diagnostics
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.inline-diagnostics"
    end,
  },

  -- Discord Rich Presence
  {
    "IogaMaster/neocord",
    event = "VeryLazy",
    config = function()
      require "configs.discord"
    end,
  },

  -- Colorizer for highlighting colors
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*", -- Apply to all file types
        html = { mode = "background" },
        css = { rgb_fn = true, names = true },
        javascript = { names = true },
        lua = { names = true },
      })
    end,
  },

  -- Copilot integration
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_enable_suggestions = true
      vim.g.copilot_assume_mapped = true
    end,
  },

  -- Commenting utility
  {
    "tpope/vim-commentary",
    event = "BufRead",
  },

  -- Treesitter for syntax highlighting and more
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    opts = function()
      return require "nvchad.configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- Telescope for fuzzy finding
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "nvchad.configs.telescope"
    end,
  },

  -- Autotag for HTML/JSX
  {
    "windwp/nvim-ts-autotag",
    event = "BufRead",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup({ enable = true })
    end,
  },

  -- Autocompletion
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path" } },
  { "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },

  -- Null-LS for additional formatters/linters
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require "configs.null-ls"
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  },

  {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Untuk ikon file
    event = "BufReadPre", -- Memuat plugin saat buffer dibuka
    config = function()
      require("configs.barbar") -- Memuat konfigurasi barbar
    end,
  },
}
