return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    config = function()
      -- Set this variable so that Tab is not taken by Copilot
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_enable_suggestions = true
      vim.g.copilot_assume_mapped = true

      require("copilot").setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          -- Avoid using <Tab> to accept, use another key combination
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
    dependencies = { "zbirenbaum/copilot.lua" },
    event = "InsertEnter",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
