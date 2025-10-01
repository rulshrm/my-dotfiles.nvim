local M = {}

M.setup = function()
  -- Konfigurasi mini.files untuk file explorer alternatif
  require('mini.files').setup({
    windows = {
      preview = true,
      width_focus = 30,
      width_preview = 30,
    },
    options = {
      -- Tampilkan dot-files
      use_as_default_explorer = false,
    },
  })
  
  -- Konfigurasi mini.indentscope untuk visualisasi indentasi
  require('mini.indentscope').setup({
    symbol = "│",
    options = { try_as_border = true },
  })
  
  -- Konfigurasi mini.pairs untuk auto-closing brackets
  require('mini.pairs').setup({})
  
  -- Jika ingin menggunakan mini.statusline
  -- require('mini.statusline').setup({})
end

return M