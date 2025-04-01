-- ~/.config/nvim/lua/plugins/init.lua
return {
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
    config = function()
      require("configs.mason").setup()
    end,
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
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("configs.null-ls")
  --   end,
  --   event = { "BufReadPre", "BufNewFile" }, -- Muat null-ls saat buffer dibuka
  -- },

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

  -- -- Which-key for keybindings
  -- {
  --   "folke/which-key.nvim",
  --   event = "VeryLazy", -- Memuat plugin hanya saat dibutuhkan
  --   config = function()
  --     require("configs.which-key").setup() -- Panggil konfigurasi modular
  --   end,
  -- },

  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      require("mini.icons").setup()
    end,
  },

  -- Nvim-notify for notifications
  {
    "rcarriga/nvim-notify",
    lazy = false, -- Muat plugin segera setelah Neovim dimulai
    config = function()
      require("configs.notify").setup() -- Panggil konfigurasi modular
    end,
  },

  -- API testing with Rest.nvim
  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("configs.rest") -- Panggil konfigurasi modular
    end,
    cmd = { "RestNvim", "RestNvimPreview", "RestNvimLast" },
  },

  -- Refactoring tool
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("configs.refactoring")
    end,
    keys = {
      { "<leader>rr", "<cmd>lua require('refactoring').select_refactor()<CR>", desc = "Refactor Code" },
    },
  },

  -- Neogen for generating comments
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup({ enabled = true })
    end,
    cmd = { "Neogen" },
  },
}
