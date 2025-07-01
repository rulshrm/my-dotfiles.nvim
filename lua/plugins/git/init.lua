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
  
  {
    "SuperBo/fugit2.nvim",
    opts = {
      keymaps = {
        graph = {
          ["<leader>gg"] = "toggle_git_graph", -- Toggle Git Graph view
          ["<leader>gf"] = "toggle_file_history", -- Toggle File History view
          ["<leader>gd"] = "toggle_git_diff", -- Toggle Git Diff view
          ["<C-k>"] = "select_prev_entry", -- Navigate up
          ["<C-j>"] = "select_next_entry", -- Navigate down
          ["<CR>"] = "select_entry", -- Select entry
          ["q"] = "close", -- Close the view
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    cmd = {
      "Fugit2Graph",
      "Fugit2FileHistory",
      "Fugit2GitDiff",
    },
  },
  
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    config = function()
      -- Git command aliases
      vim.cmd([[
        command! -nargs=0 GStatus Git
        command! -nargs=0 GCommit Git commit
        command! -nargs=0 GPush Git push
        command! -nargs=0 GPull Git pull
      ]])
    end,
  },
  
  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("git-worktree").setup({
        change_directory_command = "cd",
        update_on_change = true,
        clearjumps_on_change = true,
      })
    end,
  },
}