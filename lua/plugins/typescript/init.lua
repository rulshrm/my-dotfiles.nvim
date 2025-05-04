return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
    opts = {},
  },
  {
    "b0o/schemastore.nvim",
    ft = { "json", "jsonc" },
  },
}