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
    event = "VeryLazy",
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
    lazy = true,
    config = function()
      require("configs.devicons").setup()
    end,
  },
  {
    "DaikyXendo/nvim-material-icon",
    lazy = true,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("configs.nvim-tree").setup()
    end,
  },
}
