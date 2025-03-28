-- ~/.config/nvim/lua/plugins/init.lua
return {
  -- Formatting and linting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",            -- Format on save
    config = function()
      require "configs.conform"       -- Memuat konfigurasi utama untuk Conform
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
        "lua-language-server",        -- Lua LSP
        "html-lsp",                   -- HTML LSP
        "css-lsp",                    -- CSS LSP
        "typescript-language-server", -- TypeScript/JavaScript LSP
        "json-languageserver",        -- JSON LSP
        "yaml-language-server",       -- YAML LSP
        "vimls",                      -- Vimscript LSP
        "rust_analyzer",              -- Rust LSP
        "gopls",                      -- Go LSP
        "nimls",                      -- Nim LSP

        -- Formatters
        "prettier",           -- Prettier for formatting
        "prettierd",          -- Prettier daemon
        "stylua",             -- Lua formatter
        "rustfmt",            -- Rust formatter
        "google-java-format", -- Java formatter
        "clang-format",       -- C/C++ formatter
        "alejandra",          -- Nix formatter
        "nixpkgs-fmt",        -- Nix formatter
        "fish_indent",        -- Fish shell formatter

        -- Linters
        "eslint_d", -- ESLint daemon for JS/TS
        "ruff",     -- Python linter/formatter
      },
    },
  },

  -- Auto-save
  {
    "brianhuster/autosave.nvim",
    event = "InsertEnter",
    opts = {
      enabled = true, -- Aktifkan autosave
      execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
      events = { "InsertLeave", "TextChanged" }, -- Simpan otomatis saat meninggalkan mode insert atau teks berubah
      conditions = {
        exists = true, -- Hanya simpan jika file ada
        filename_is_not = { "plugins.lua" }, -- Jangan simpan file tertentu
        filetype_is_not = { "gitcommit", "markdown" }, -- Jangan simpan file dengan tipe tertentu
        modifiable = true, -- Hanya simpan file yang dapat dimodifikasi
      },
      write_all_buffers = false, -- Hanya simpan buffer aktif
      debounce_delay = 1000, -- Tunda penyimpanan otomatis (dalam milidetik)
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

  -- Copilot completion
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "github/copilot.vim" },
    config = function()
      require("copilot_cmp").setup()
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
    event = "InsertEnter", -- Memuat plugin saat memasuki mode insert
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Bergantung pada Treesitter
    config = function()
      require("nvim-ts-autotag").setup({
        filetypes = {
          "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue", "tsx", "jsx", "xml",
        },
        skip_tags = { "area", "base", "br", "col", "command", "embed", "hr", "img", "slot", "input", "keygen", "link", "meta", "param", "source", "track", "wbr" },
      })
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

  -- Import cost for JavaScript/TypeScript
  {
    "barrett-ruth/import-cost.nvim",
    build = "sh install.sh yarn",
    event = { "BufReadPre", "BufNewFile" }, -- Memuat plugin saat buffer dibuka
    config = function()
      require("import-cost").setup({
        silent = false, -- Tampilkan pesan error jika ada masalah
        filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }, -- Filetype yang didukung
      })
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

  -- barbar for bufferline
  {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Untuk ikon file
    event = "BufReadPre",                             -- Memuat plugin saat buffer dibuka
    config = function()
      require("configs.barbar")                       -- Memuat konfigurasi barbar
    end,
  },

  -- Which-key for keybindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- Memuat plugin hanya saat dibutuhkan
    config = function()
      require("which-key").setup {
        plugins = {
          marks = true, -- Tampilkan marks
          registers = true, -- Tampilkan registers
          spelling = {
            enabled = true, -- Aktifkan saran ejaan
            suggestions = 20, -- Jumlah saran ejaan
          },
        },
        key_labels = {
          ["<leader>"] = "SPC", -- Tampilkan <leader> sebagai "SPC"
          ["<CR>"] = "RET",
          ["<Tab>"] = "TAB",
        },
        window = {
          border = "rounded", -- Gunakan border bulat
          position = "bottom", -- Tampilkan di bagian bawah
          margin = { 1, 0, 1, 0 }, -- Margin di sekitar popup
          padding = { 2, 2, 2, 2 }, -- Padding di dalam popup
        },
        layout = {
          height = { min = 4, max = 25 }, -- Tinggi minimum dan maksimum
          width = { min = 20, max = 50 }, -- Lebar minimum dan maksimum
          spacing = 3, -- Spasi antar kolom
          align = "center", -- Rata tengah
        },
        ignore_missing = true, -- Abaikan keybinding yang tidak ada
        show_help = true, -- Tampilkan bantuan di popup
      }
    end,
  },

  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      require("mini.icons").setup()
    end,
  },
}
