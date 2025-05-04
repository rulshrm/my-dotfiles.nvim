return {
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
  {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("configs.mason").setup()
    end,
  },
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
}