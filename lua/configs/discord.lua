-- The setup config table shows all available config options with their default values:
require("neocord").setup({
    -- General options
    logo                = "https://avatars.githubusercontent.com/u/42622170?v=4",                     -- Gunakan "auto" untuk logo default Neovim
    logo_tooltip        = "vscode killers!",                  -- Tooltip yang lebih profesional
    main_image          = "language",                 -- Tampilkan icon bahasa pemrograman
    client_id           = "1157438221865717891",      -- Client ID Discord Anda
    log_level           = nil,                        -- Set level log ke "warn" untuk debugging
    debounce_timeout    = 5,                          -- Kurangi timeout untuk update yang lebih responsif
    blacklist           = {},
    file_assets         = {},                           -- Daftar jenis file atau buffer di mana neocord tidak akan aktif (contoh: {"gitcommit", "markdown"}).
    show_time           = false,                        -- Tampilkan waktu
    global_timer        = false,                        -- Timer global untuk sesi coding

    -- Rich Presence text options
    editing_text        = "📝 Editing %s",                                         -- Format teks saat Anda sedang mengedit sebuah file. '%s' akan diganti dengan nama file.
    file_explorer_text  = "🔍 Browse %s",                                        -- Format teks saat Anda berada di file explorer (misalnya, nvim-tree). '%s' adalah nama direktori.
    git_commit_text     = "📦 Committing changes",                                 -- Teks yang ditampilkan saat Anda sedang dalam proses melakukan 'git commit'.
    plugin_manager_text = "🔧 Managing plugins",                                   -- Teks yang ditampilkan saat Anda berinteraksi dengan plugin manager (misalnya, lazy.nvim).
    reading_text        = "📖 Reading %s",                                         -- Format teks saat membuka file dalam mode hanya-baca (read-only). '%s' adalah nama file.
    workspace_text      = "🚀 Working on %s",                                      -- Teks yang menunjukkan nama proyek/workspace. '%s' adalah nama folder.
    line_number_text    = "📍 Line %s of %s",                                     -- Format teks untuk info baris. '%s' pertama adalah baris saat ini, '%s' kedua adalah total baris.
    terminal_text       = "💻 Using Terminal",                                     -- Teks yang ditampilkan saat Anda sedang aktif di dalam buffer terminal Neovim.
})
