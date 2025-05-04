-- filepath: ~/.config/nvim/lua/plugins/init.lua
return {
  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neodev.nvim", opts = {} },
      "mason.nvim",
      "mason-lspconfig.nvim",
    },
    config = function()
      require("configs.lspconfig").setup()
    end,
  },

  -- Mason for managing LSP servers, formatters, and linters
  {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("configs.mason").setup()
    end,
  },

  -- Null-ls for integrating external formatters and linters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "mason.nvim",
    },
    config = function()
      require("configs.null-ls").setup()
    end,
  },

  -- Auto-save
  {
    "brianhuster/autosave.nvim",
    event = "InsertEnter",
    opts = {
      enabled = true, -- Aktifkan autosave
      execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
      events = { "InsertLeave", "TextChanged"},
      conditions = {
        exists = true, -- Hanya simpan jika file ada
        filename_is_not = { "plugins.lua" }, -- Jangan simpan file tertentu
        filetype_is_not = { "gitcommit", "markdown" }, -- Jangan simpan file dengan tipe tertentu
        modifiable = true, -- Hanya simpan file yang dapat dimodifikasi
      },
      write_all_buffers = false, -- Hanya simpan buffer aktif
      debounce_delay = 2000, -- Tunda penyimpanan otomatis (dalam milidetik)
    },
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      return require "configs.gitsigns"
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
      vim.g.copilot_node_command = "node"
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

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" }
    },
    config = function()
      require("configs.copilot-chat").setup()
    end,
    keys = {
      { "<leader>cc", "<cmd>CopilotChat<CR>", desc = "CopilotChat - Open" },
      { "<leader>ce", "<cmd>CopilotChatExplain<CR>", desc = "CopilotChat - Explain code" },
      { "<leader>ct", "<cmd>CopilotChatTests<CR>", desc = "CopilotChat - Generate tests" },
      { "<leader>cr", "<cmd>CopilotChatReview<CR>", desc = "CopilotChat - Review code" },
      { "<leader>cf", "<cmd>CopilotChatRefactor<CR>", desc = "CopilotChat - Refactor code" },
      -- Tambahkan keybinding untuk prompt kustom
      { "<leader>cd", "<cmd>CopilotChatDocumentation<CR>", desc = "CopilotChat - Generate docs" },
      { "<leader>cb", "<cmd>CopilotChatFixBug<CR>", desc = "CopilotChat - Fix bugs" },
      { "<leader>co", "<cmd>CopilotChatOptimize<CR>", desc = "CopilotChat - Optimize code" },
    },
    event = "VeryLazy",
  },

  -- Commenting utility
  {
    "tpope/vim-commentary",
    event = "BufRead",
    init = function()
      -- Ubah keybinding default gc ke alternatif lain
      vim.keymap.set("n", "<leader>/", "<Plug>Commentary", { desc = "Comment line" })
      vim.keymap.set("v", "<leader>/", "<Plug>Commentary", { desc = "Comment selection" })
      
      -- Nonaktifkan keybinding default gc untuk menghindari konflik
      vim.g.commentary_map_backslash = 0
    end,
  },

  -- Treesitter for syntax highlighting and more
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    opts = function()
      return require "configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- Telescope for fuzzy finding
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { 
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = function()
        return require("configs.telescope")
    end,
    config = function(_, opts)
        require("telescope").setup(opts)
        -- Load extensions
        require("telescope").load_extension("fzf")
    end,
  },

  -- Autotag for HTML/JSX
  {
    "windwp/nvim-ts-autotag",
    event = { "InsertEnter", "BufReadPre", "BufNewFile" },
    dependencies = { 
        "nvim-treesitter/nvim-treesitter",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        require("nvim-ts-autotag").setup({
            -- Filetypes yang didukung
            filetypes = {
                'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 
                'svelte', 'vue', 'tsx', 'jsx', 'rescript', 'xml',
                'php', 'markdown', 'astro', 'glimmer', 'handlebars', 'hbs'
            },
            -- Tag yang akan dilewati
            skip_tags = {
                'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 
                'slot', 'input', 'keygen', 'link', 'meta', 'param', 'source', 
                'track', 'wbr', 'menuitem'
            },
            -- Opsi tambahan
            enable_close_on_slash = true,    -- Tutup tag saat mengetik /
            enable_rename = true,            -- Rename tag otomatis
            enable_close = true,             -- Enable auto close
            enable = true,                   -- Enable plugin
            indent_after_close = true,       -- Auto indent setelah menutup tag
            custom_elements = {},            -- Custom elements jika diperlukan
            custom_tags = {},                -- Custom tags jika diperlukan
        })

        -- Tambahkan autocmd untuk memastikan plugin berfungsi
        vim.api.nvim_create_autocmd(
            { "FileType" },
            {
                pattern = { 
                    "html", "javascript", "typescript", "javascriptreact", 
                    "typescriptreact", "svelte", "vue", "tsx", "jsx", "xml",
                    "php", "markdown", "astro", "glimmer", "handlebars", "hbs"
                },
                callback = function()
                    vim.cmd("TSEnable highlight")
                    vim.cmd("TSEnable indent")
                    vim.cmd("TSEnable autotag")
                end,
            }
        )
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("configs.cmp")
    end,
  },

  --- Import cost for JavaScript/TypeScript
  {
    "barrett-ruth/import-cost.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    build = "sh install.sh yarn",
    event = { "BufReadPre", "BufNewFile" },
    ft = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact"
    },
    config = function()
        require("import-cost").setup()  -- Gunakan konfigurasi default
    end
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

  -- Typescript tools
{
    "pmizio/typescript-tools.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      {
        "saghen/blink.cmp",
        -- Ensure blink.cmp is loaded before typescript-tools
        lazy = false,
        priority = 1000,
      }
    },
  },

  {
    "razak17/tailwind-fold.nvim",
    opts = {
      min_chars = 50,
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "html", "svelte", "astro", "vue", "typescriptreact" },
  },

  {
    "MaximilianLloyd/tw-values.nvim",
    keys = {
      { "<Leader>cv", "<CMD>TWValues<CR>", desc = "Tailwind CSS values" },
    },
    opts = {
      border = "rounded", -- Valid window border style,
      show_unknown_classes = true                   -- Shows the unknown classes popup
    }
  },

  {
    "laytan/tailwind-sorter.nvim",
    cmd = {
      "TailwindSort",
      "TailwindSortOnSaveToggle"
    },
    keys = {
      { "<Leader>cS", "<CMD>TailwindSortOnSaveToggle<CR>", desc = "toggle Tailwind CSS classes sort on save" },

    },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
    build = "cd formatter && npm i && npm run build",
    config = true,
  },

  {
    "axelvc/template-string.nvim",
    event = "InsertEnter",
    ft = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
    config = true, -- run require("template-string").setup()
  },

  {
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    config = true,
  },

  {
    "dmmulroy/ts-error-translator.nvim",
    config = true
  },

  -- Debugging with nvim-dap
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("configs.dap")
    end,
  },

  -- Tailwind Fold - Untuk melipat kelas Tailwind yang panjang
  {
    "razak17/tailwind-fold.nvim",
    event = { "BufReadPost", "BufNewFile" }, -- Load saat buffer dibuka
    opts = {
      min_chars = 50,      -- Minimal karakter sebelum dilipat
      fold_last_level = true, -- Lipat level terakhir
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = {
      "html", 
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte", 
      "astro", 
      "vue"
    },
  },

  -- Tailwind Values - Untuk melihat nilai dari kelas Tailwind
  {
    "MaximilianLloyd/tw-values.nvim",
    keys = {
      { "<leader>tw", "<cmd>TWValues<cr>", desc = "Show Tailwind CSS values" },
    },
    opts = {
      border = "rounded",           -- Style border window
      show_unknown_classes = true,  -- Tampilkan kelas yang tidak dikenal
      focus_preview = true,         -- Focus ke window preview
      copy_register = "+",          -- Register untuk menyalin nilai
      keymaps = {
        copy = "<C-c>"             -- Keybind untuk menyalin nilai
      }
    }
  },

  -- Tailwind Sorter - Untuk mengurutkan kelas Tailwind
  {
    "laytan/tailwind-sorter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim"
    },
    build = "cd formatter && npm i && npm run build",
    config = function()
      require("tailwind-sorter").setup({
        on_save_enabled = true,     -- Urutkan saat menyimpan
        on_save_pattern = {         -- Pattern file yang akan diurutkan
          "*.html",
          "*.js",
          "*.jsx",
          "*.tsx",
          "*.twig",
          "*.hbs",
          "*.php",
          "*.heex",
          "*.astro"
        },
        node_path = "node",
      })
    end,
    keys = {
      { "<leader>ts", "<cmd>TailwindSort<cr>", desc = "Sort Tailwind classes" },
      { "<leader>tS", "<cmd>TailwindSortOnSaveToggle<cr>", desc = "Toggle Tailwind sort on save" },
    },
  },

  {
    "jake-stewart/multicursor.nvim",
    event = "VeryLazy",
    config = function()
        -- Use pcall to safely require the module
        local status_ok, multicursor = pcall(require, "multicursor.nvim")
        if not status_ok then
            vim.notify("multicursor.nvim not found!", vim.log.levels.WARN)
            return
        end

        multicursor.setup({
            normal_keys = {
                ["<M-n>"] = {
                    method = multicursor.normal_next,
                    opts = { desc = "Create cursor down" }
                },
                ["<M-p>"] = {
                    method = multicursor.normal_prev,
                    opts = { desc = "Create cursor up" }
                },
                ["<M-S-n>"] = {
                    method = multicursor.extend_next,
                    opts = { desc = "Select next occurrence" }
                },
                ["<M-S-p>"] = {
                    method = multicursor.extend_prev,
                    opts = { desc = "Select previous occurrence" }
                },
            },
            visual_keys = {
                ["<M-n>"] = {
                    method = multicursor.visual_next,
                    opts = { desc = "Select next occurrence" }
                },
                ["<M-p>"] = {
                    method = multicursor.visual_prev,
                    opts = { desc = "Select previous occurrence" }
                },
            },
            hint_config = {
                border = "rounded",
                position = "bottom-right",
            },
            generate_hints = {
                normal = true,
                visual = true,
                insert = false,
            },
        })
    end,
    keys = {
        { "<leader>m", "<cmd>lua require('multicursor.nvim').start()<CR>", desc = "Start multicursor" },
        { "<leader>M", "<cmd>lua require('multicursor.nvim').extend_cursors()<CR>", desc = "Extend cursors" },
    },
  },
}
