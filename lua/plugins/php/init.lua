return {
  -- Laravel Integration
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-dotenv",
      "MunifTanjim/nui.nvim",
    },
    cmd = { 
      "Artisan", 
      "Composer", 
      "Laravel",
      "LaravelInfo",
      "LaravelClearCache" 
    },
    keys = {
      { "<leader>la", ":Artisan<cr>", desc = "Artisan commands" },
      { "<leader>lr", ":Artisan route:list<cr>", desc = "List routes" },
      { "<leader>lm", ":Artisan make:", desc = "Artisan make" },
      { "<leader>lt", ":Artisan tinker<cr>", desc = "Artisan tinker" },
      { "<leader>lc", ":LaravelClearCache<cr>", desc = "Clear cache" },
    },
    config = function()
      require("laravel").setup({
        features = {
          route_info = true,
          model_info = true,
          lsp = {
            enabled = true,
          },
        },
      })
    end,
    ft = { "php", "blade" },
  },

  -- Blade Template Support
  {
    "jwalton512/vim-blade",
    ft = "blade",
    dependencies = { "sheerun/vim-polyglot" },
  },

  -- PHP Development Tools
  {
    "tpope/vim-dispatch",
    cmd = { "Dispatch", "Make", "Focus", "Start" },
  },

  -- Composer Integration
  {
    "noahfrederick/vim-composer",
    dependencies = { "tpope/vim-dispatch" },
    ft = "php",
    cmd = { "Composer", "ComposerUpdate" },
  },

  -- PHP Specific Plugins
  {
    "StanAngeloff/php.vim",
    ft = "php",
    config = function()
      vim.g.php_var_selector_is_identifier = 1
      vim.g.php_syntax_extensions_enabled = {
        "bcmath", "bz2", "core", "curl", "date", 
        "dom", "json", "libxml", "mbstring", "mysqli",
        "pdo", "pgsql", "Phar", "soap", "sqlite3", 
        "tokenizer", "xml", "xsl"
      }
    end,
  },

  -- PHP Debugging
  {
    "vim-vdebug/vdebug",
    ft = "php",
    config = function()
      vim.g.vdebug_options = {
        port = 9003,
        break_on_open = 0,
        ide_key = 'PHPSTORM',
        debug_window_level = 2,
        debug_file_level = 0,
      }
    end,
  },

  -- Replace vim-phpunit with neotest + PHPUnit adapter
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "olimorris/neotest-phpunit" -- PHPUnit adapter
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-phpunit")({
            phpunit_cmd = function()
              return "vendor/bin/phpunit"
            end,
            root_files = { "composer.json", "phpunit.xml", "phpunit.xml.dist" },
            filter_dirs = { "vendor", "node_modules" },
          })
        }
      })
    end,
    keys = {
      { "<leader>tt", "<cmd>lua require('neotest').run.run()<CR>", desc = "Run Nearest Test" },
      { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Run File" },
      { "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<CR>", desc = "Toggle Summary" },
      { "<leader>to", "<cmd>lua require('neotest').output.open()<CR>", desc = "Show Output" },
      { "<leader>tp", "<cmd>lua require('neotest').output_panel.toggle()<CR>", desc = "Toggle Output Panel" },
    },
  },
}