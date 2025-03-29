require("rest-nvim").setup({
  result_split_horizontal = false, -- Hasil ditampilkan secara vertikal
  skip_ssl_verification = false,   -- Jangan lewati verifikasi SSL
  highlight = {
    enabled = true,                -- Aktifkan highlight
    timeout = 150,                 -- Timeout untuk highlight
  },
  result = {
    show_url = true,               -- Tampilkan URL di hasil
    show_http_info = true,         -- Tampilkan informasi HTTP
    show_headers = true,           -- Tampilkan header
  },
  jump_to_request = false,         -- Jangan lompat ke permintaan secara otomatis
  env_file = ".env",               -- File environment default
  custom_dynamic_variables = {},  -- Variabel dinamis kustom
  yank_dry_run = true,             -- Jangan salin hasil ke clipboard
})