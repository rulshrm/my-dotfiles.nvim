return {
  {
    "brianhuster/autosave.nvim",
    event = "InsertEnter",
    opts = {
      enabled = true,
      events = { "InsertLeave", "TextChanged" },
      debounce_delay = 2000,
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      return require "configs.gitsigns"
    end,
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },
}