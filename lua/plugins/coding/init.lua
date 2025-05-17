return {
  {
    "barrett-ruth/import-cost.nvim",
    build = "sh install.sh npm",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufRead", "BufNewFile" },
    ft = {
      "javascript", 
      "javascriptreact",
      "typescript", 
      "typescriptreact"
    },
    config = function()
      require("import-cost").setup({
        highlight = {
          enable = true,
          groups = {
            small = "ImportCostSmall",    -- 0-10kb
            medium = "ImportCostMedium",  -- 10-50kb
            large = "ImportCostLarge",    -- 50kb+
          },
        },
        virtual_text = {
          enabled = true,
          format = function(cost)
            if cost.error then
              return "[Error]"
            end
            return ("(size: %s)"):format(cost.size)
          end,
        },
      })
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