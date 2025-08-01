local M = {}

M.setup = function()
  require("hlchunk").setup({
    chunk = {
      enable = true,
      support_filetypes = {
        "*.js",
        "*.jsx",
        "*.ts",
        "*.tsx",
        "*.vue",
        "*.svelte",
        "*.lua",
        "*.php",
        "*.python",
        "*.*"
      },
      chars = {
        horizontal_line = "─",
        vertical_line = "│",
        left_top = "╭",
        left_bottom = "╰",
        right_arrow = "─",
      },
      style = {
        { fg = "#806d9c" },
      },
    },
    indent = {
      enable = true,  -- Indent guide
      use_treesitter = true,  -- Gunakan treesitter untuk indentasi yang lebih akurat
      chars = {
        "│",
      },
      style = {
        { fg = "#2d3343" },
      },
    },
    line_num = {
      enable = true,
      style = "#806d9c",
    },
    blank = {
      enable = true,
      chars = {
        "·",
      },
      style = {
        { fg = "#2d3343" },
      },
    },
  })
end

return M

