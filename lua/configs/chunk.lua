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
      enable = true,
      use_treesitter = true,
      chars = {
        "│",
      },
      style = {
        { fg = "#2d3343" },
      },
    },
    line_num = {
      enable = true,
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

