return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        html = { "prettier" },
        css = { "prettier", "prettierd" },
        javascript = { "prettierd" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        go = { "gofmt" },
        rust = { "rustfmt" },
        python = { "black" },
        java = { "google-java-format" },
        c = { "clang-format" },
        nix = { "alejandra", "nixpkgs-fmt" },
        fish = { "fish_indent" },
        svelte = { "prettier" },
        markdown = { "prettier", "prettierd" },
      },
    },
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Menggunakan default config dari nvchad
      require("nvchad.configs.lspconfig").defaults()

      -- Menambahkan pengaturan custom TypeScript
      require'lspconfig'.ts_ls.setup{
        on_attach = function(client, bufnr)
          print("Typescript LSP connected")
        end
      }

      -- Menambahkan pengaturan custom dari file custom
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
      },
    },
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    event = "User Filepost",
    opts = function ()
      return require "nvchad.configs.gitsigns"
    end
  },

  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.chunk"
      --
    end,
  },

  {
    "wakatime/vim-wakatime",
    lazy = false,
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      dofile(vim.g.base46_cache .. "devicons")
      return { override = require "nvchad.icons.devicons" }
    end,
  },

  --{
  --  "lukas-reineke/indent-blankline.nvim",
  --  main = "ibl",
  --  ---@module "ibl"
  --  ---@type ibl.config
  --  opts = {},
  --  enabled = false,
  --},

    {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "│", highlight = "IblChar" },
      scope = { char = "│", highlight = "IblScopeChar" },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)

      dofile(vim.g.base46_cache .. "blankline")
    end,
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.inline-diagnostics"
    end,
  },

  {
    "IogaMaster/neocord",
    event = "VeryLazy",
    config = function()
      require "configs.discord"
    end,
  },
  { "nvchad/volt",     lazy = true },
  {
    "nvchad/minty",
    lazy = true,
    config = function()
      require "configs.minty"
    end,
  },
  {
  "github/copilot.vim",
  lazy = false,
  config = function()  -- Mapping tab is already used by NvChad
    vim.g.copilot_no_tab_map = true;
    vim.g.copilot_enable_suggestions = true;
    vim.g.copilot_assume_mapped = true;
    vim.g.copilot_tab_fallback = "";
  -- The mapping is set to other key, see custom/lua/mappings
  -- or run <leader>ch to see copilot mapping section
  end
  },
  {
  'tpope/vim-commentary',
  event = 'BufRead'  -- Opsi untuk memuat plugin ketika file dibaca
  },

  {
  "NvChad/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      "*",  -- Apply to all file types
      html = { mode = "background" },  -- Color preview as background color for HTML
      css = { rgb_fn = true, names = true, rgba_fn = true, rrgbaa_fn = true },  -- Enable RGB, RGBA, and color names for CSS
      javascript = { names = true, rgba_fn = true, rrgbaa_fn = true },  -- Enable color names, RGBA for Javascript
      lua = { names = true, rgb_fn = true, rgba_fn = true, rrgbaa_fn = true },  -- Enable RGB, RGBA, and color names for Lua
      -- Support for more formats
      -- Enable HSL and RGBA for additional color notations
      hsl_fn = true,  -- Enable HSL function (hsl(360, 100%, 100%))
      aarrggbb = true,  -- Enable AARRGGBB format (e.g., #AARRGGBB)
      rrgbrgba = true,  -- Enable RRGGBBAA and similar formats
    })
  end
  },


  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     {
  --       "supermaven-inc/supermaven-nvim",
  --       opts = {},
  --     },
  --   },
  --
  --   opts = function (_, opts)
  --     opts.sources[1].trigger_chars = {"-"}
  --     table.insert(opts.sources, 1, {name = "supermaven"})
  --   end
  -- },

  { "nvchad/menu",     lazy = true },

  { "nvchad/showkeys", cmd = "ShowkeysToggle", opts = { position = "top-center" } },

  { "nvchad/timerly",  cmd = "TimerlyToggle" },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "nvchad.configs.telescope"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "nvchad.configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
