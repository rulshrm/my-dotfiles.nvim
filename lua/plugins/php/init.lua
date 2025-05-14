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

  -- PHPUnit Testing
  {
    "rcarriga/vim-phpunit",
    dependencies = { "tpope/vim-dispatch" },
    ft = "php",
    config = function()
      vim.g.phpunit_bin = './vendor/bin/phpunit'
      vim.g.phpunit_options = '--colors=always'
    end,
  },
}