return {
  {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "BufReadPre",
    config = function()
      require("configs.barbar")
    end,
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      require("configs.notify").setup()
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = function()
      require("configs.chunk").setup()
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      require("configs.devicons").setup()
    end,
  },
  {
    "DaikyXendo/nvim-material-icon",
    lazy = false,
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("configs.nvim-tree").setup()
    end,
  },
}
