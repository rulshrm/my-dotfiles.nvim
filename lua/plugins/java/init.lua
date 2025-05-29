return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
  },
  {
    "artur-shaik/vim-javacomplete2",
    ft = "java",
    config = function()
      vim.g.JavaComplete_EnableDefaultMappings = 1
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "java" })
      end
    end,
  }
}