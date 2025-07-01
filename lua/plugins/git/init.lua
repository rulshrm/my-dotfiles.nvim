return {
  -- Existing gitsigns plugin...
  
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
        view = {
          default = {
            layout = "diff2_horizontal",
            winbar_info = true,
          },
          merge_tool = {
            layout = "diff3_horizontal",
            disable_diagnostics = true,
          },
        },
        hooks = {
          diff_buf_read = function()
            vim.opt_local.wrap = false
            vim.opt_local.list = false
          end,
        },
      })
    end,
  },
  
  {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    config = function()
      require("git-conflict").setup({
        default_mappings = true,
        default_commands = true,
        disable_diagnostics = false,
        highlights = {
          incoming = "DiffAdd",
          current = "DiffText",
        },
      })
    end,
  },
}