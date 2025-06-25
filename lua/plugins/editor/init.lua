return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = function()
      return require "configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "InsertEnter", "BufReadPre", "BufNewFile" },
    dependencies = { 
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
        filetypes = {
          'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 
          'svelte', 'vue', 'tsx', 'jsx', 'xml', 'php', 'markdown', 
          'astro', 'glimmer', 'handlebars', 'hbs'
        },
      }
    }
  },
}