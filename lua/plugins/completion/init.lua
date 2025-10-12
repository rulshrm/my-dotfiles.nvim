return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",     -- pastikan source luasnip aktif di cmp
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("configs.cmp")
    end,
  },

  -- Use both copilot.lua and github/copilot.vim for both ghost text and completion
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    config = function()
      -- Variabel berikut efektif untuk copilot.vim, bukan copilot.lua.
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_enable_suggestions = true
      vim.g.copilot_assume_mapped = true

      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        -- Enable panel for more functionality
        panel = { enabled = true },
        -- Disable copilot-cmp integration to restore ghost text
        filetypes = {
          ["*"] = true,
        },
      })
    end,
  },

  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Enable Copilot suggestion (ghost text)
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      -- Restore ghost text functionality
      vim.g.copilot_enabled = true
      vim.g.copilot_enable_suggestions = true
    end,
  },

  -- Configure copilot-cmp as a secondary integration
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup({
        event = { "InsertEnter", "LspAttach" },
        fix_pairs = true,
      })
    end,
  },
}
