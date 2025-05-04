return {
  {
    "barrett-ruth/import-cost.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    build = "sh install.sh yarn",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      require("import-cost").setup()
    end,
  },
  {
    "razak17/tailwind-fold.nvim",
    opts = { min_chars = 50 },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "html", "svelte", "astro", "vue", "typescriptreact" },
  },
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
}