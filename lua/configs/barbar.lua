-- Konfigurasi untuk barbar.nvim
vim.g.barbar_auto_setup = false -- Nonaktifkan auto-setup untuk kontrol penuh

require("bufferline").setup {
  animation = true, -- Animasi saat berpindah tab
  auto_hide = false, -- Jangan sembunyikan tab jika hanya ada satu buffer
  tabpages = true, -- Tampilkan tab untuk setiap tabpage
  closable = true, -- Tampilkan tombol close di setiap tab
  clickable = true, -- Izinkan klik untuk memilih atau menutup tab
  icons = {
    buffer_index = true, -- Tampilkan nomor buffer
    buffer_number = false, -- Jangan tampilkan nomor buffer
    button = "", -- Ikon untuk tombol close
    filetype = { enabled = true }, -- Tampilkan ikon file berdasarkan tipe file
    separator = { left = "▎", right = "" }, -- Separator antar tab
    modified = { button = "●" }, -- Ikon untuk buffer yang dimodifikasi
  },
  maximum_padding = 1, -- Padding maksimum antar tab
  maximum_length = 30, -- Panjang maksimum nama tab
  semantic_letters = true, -- Gunakan huruf semantik untuk navigasi
  no_name_title = "[No Name]", -- Nama default untuk buffer tanpa nama
}