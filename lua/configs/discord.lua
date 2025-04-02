-- The setup config table shows all available config options with their default values:
require("neocord").setup({
    -- General options
    logo                = "auto",                     -- Gunakan "auto" untuk logo default Neovim
    logo_tooltip        = "Neovim",                  -- Tooltip yang lebih profesional
    main_image          = "language",                 -- Tampilkan icon bahasa pemrograman
    client_id           = "1157438221865717891",      -- Client ID Discord Anda
    log_level           = "warn",                     -- Set level log ke "warn" untuk debugging
    debounce_timeout    = 5,                          -- Kurangi timeout untuk update yang lebih responsif
    blacklist           = {                           -- Blacklist untuk file/folder tertentu
        "^$",                                          -- Ignore empty filename
        "term://",                                     -- Ignore terminal buffer
        "fugitive://",                                 -- Ignore fugitive buffer
        "node_modules",                                -- Ignore node_modules
        ".git",                                        -- Ignore git directory
    },
    file_assets         = {                            -- Custom file assets
        js = "JavaScript",
        ts = "TypeScript",
        jsx = "React",
        tsx = "React TypeScript",
        lua = "Lua",
        rust = "Rust",
        go = "Go",
    },
    show_time           = true,                        -- Tampilkan waktu
    global_timer        = true,                        -- Timer global untuk sesi coding

    -- Rich Presence text options
    editing_text        = "📝 Editing %s",
    file_explorer_text  = "🔍 Browsing %s",
    git_commit_text     = "📦 Committing changes",
    plugin_manager_text = "🔧 Managing plugins",
    reading_text        = "📖 Reading %s",
    workspace_text      = "🚀 Working on %s",
    line_number_text    = "📍 Line %s of %s",
    terminal_text       = "💻 Using Terminal",
})
