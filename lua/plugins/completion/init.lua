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

  -- Ganti ke copilot.lua agar integrasi dengan copilot-cmp benar,
  -- dan pastikan Tab tidak digunakan untuk accept suggestion.
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    config = function()
      -- Variabel berikut efektif untuk copilot.vim, bukan copilot.lua.
      -- Saya set sesuai permintaan Anda; tidak mengganggu copilot.lua.
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_enable_suggestions = true
      vim.g.copilot_assume_mapped = true

      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          -- Jangan pakai <Tab> agar Tab tetap indent;
          -- gunakan kombinasi lain untuk accept, mis. <C-l>.
          keymap = {
            accept = "<C-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = { enabled = false },
      })
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
