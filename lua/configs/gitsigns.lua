return {
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  numhl = false, -- Nonaktifkan nomor baris dengan highlight
  linehl = false, -- Nonaktifkan highlight baris
  watch_gitdir = {
    interval = 1000, -- Interval untuk memeriksa perubahan di direktori Git
  },
  current_line_blame = true, -- Tampilkan blame di baris saat ini
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- Tampilkan blame di akhir baris
    delay = 1000, -- Tunda sebelum menampilkan blame
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  sign_priority = 6, -- Prioritas tanda
  update_debounce = 200, -- Tunda pembaruan
  status_formatter = nil, -- Gunakan formatter bawaan
  max_file_length = 40000, -- Nonaktifkan untuk file besar
}