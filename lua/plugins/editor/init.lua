return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    opts = function()
      return require "configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
      if opts.ensure_installed and #opts.ensure_installed > 0 then
        pcall(require("nvim-treesitter").install, opts.ensure_installed)
      end
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "InsertEnter", "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup {
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      }

      local select = require "nvim-treesitter-textobjects.select"
      local move = require "nvim-treesitter-textobjects.move"

      -- Textobjects select keymaps
      vim.keymap.set({ "x", "o" }, "af", function()
        select.select_textobject("@function.outer", "textobjects")
      end, { desc = "Select around function" })
      vim.keymap.set({ "x", "o" }, "if", function()
        select.select_textobject("@function.inner", "textobjects")
      end, { desc = "Select inside function" })
      vim.keymap.set({ "x", "o" }, "ac", function()
        select.select_textobject("@class.outer", "textobjects")
      end, { desc = "Select around class" })
      vim.keymap.set({ "x", "o" }, "ic", function()
        select.select_textobject("@class.inner", "textobjects")
      end, { desc = "Select inside class" })

      -- Textobjects move keymaps
      vim.keymap.set({ "n", "x", "o" }, "]m", function()
        move.goto_next_start("@function.outer", "textobjects")
      end, { desc = "Next function start" })
      vim.keymap.set({ "n", "x", "o" }, "]c", function()
        move.goto_next_start("@class.outer", "textobjects")
      end, { desc = "Next class start" })
      vim.keymap.set({ "n", "x", "o" }, "[m", function()
        move.goto_previous_start("@function.outer", "textobjects")
      end, { desc = "Previous function start" })
      vim.keymap.set({ "n", "x", "o" }, "[c", function()
        move.goto_previous_start("@class.outer", "textobjects")
      end, { desc = "Previous class start" })
    end,
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    branch = "master",
    config = function()
      require("configs.visual-multi").setup()
    end,
  },
}