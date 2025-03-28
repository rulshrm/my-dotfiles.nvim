local M = {}

M.setup = function()
  local notify = require("notify")
  vim.notify = notify -- Ganti fungsi `vim.notify` bawaan dengan `nvim-notify`

  notify.setup({
    stages = "fade_in_slide_out", -- Animasi notifikasi
    timeout = 3000, -- Waktu tampil notifikasi (dalam milidetik)
    background_colour = "#000000", -- Warna latar belakang
    fps = 30, -- Frame per second untuk animasi
    render = "default", -- Gaya render (default, minimal, atau compact)
    icons = {
      ERROR = "",
      WARN = "",
      INFO = "",
      DEBUG = "",
      TRACE = "✎",
    },
  })
end

return M