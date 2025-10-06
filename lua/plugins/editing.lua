return {
  { "numToStr/Comment.nvim", keys = { "gc", "gb" }, opts = {} },
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      fast_wrap = {},
    },
  },
}
