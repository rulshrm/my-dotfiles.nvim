return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip", -- source of snippets for cmp
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require "configs.cmp"
    end,
  },

  -- Copilot via copilot.lua (not copilot.vim) for better integration with cmp
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    config = function()
      -- Does not affect copilot.lua, but safe to set
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_enable_suggestions = true
      vim.g.copilot_assume_mapped = true

      require("copilot").setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          -- Avoid using <Tab> to accept; use another key combination
          keymap = {
            accept = "<C-l>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = { enabled = false },
      }
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua", "hrsh7th/nvim-cmp" },
    event = "InsertEnter",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
