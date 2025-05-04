return {
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    keys = {
      { "<leader>cc", "<cmd>lua require('neogen').generate()<CR>", desc = "Generate Documentation" },
    },
  },
}