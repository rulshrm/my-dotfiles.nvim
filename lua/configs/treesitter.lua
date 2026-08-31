-- ~/.config/nvim/lua/configs/treesitter.lua

return {
  install_dir = vim.fs.joinpath(vim.fn.stdpath "data", "site"),
  ensure_installed = {
    "vim",
    "vimdoc",
    "lua",
    "luadoc",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "json",
    "yaml",
    "markdown",
    "markdown_inline",
    "php",
    "blade",
    "bash",
    "dockerfile",
    "c",
    "cpp",
    "cmake",
  },
}

