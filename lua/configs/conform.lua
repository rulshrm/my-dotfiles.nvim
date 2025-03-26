-- Configuration for Conform.nvim
local options = {
  -- Formatters grouped by filetype
  formatters_by_ft = {
    -- Web development
    html = { "prettierd" }, -- HTML formatter
    css = { "prettierd" }, -- CSS formatter
    javascript = { "prettierd" }, -- JavaScript formatter (daemon)
    javascriptreact = { "prettierd" }, -- React (JSX) formatter
    typescript = { "prettierd" }, -- TypeScript formatter
    typescriptreact = { "prettierd" }, -- React (TSX) formatter
    svelte = { "prettier" }, -- Svelte formatter

    -- Markup and configuration files
    markdown = { "prettierd" }, -- Markdown formatter
    yaml = { "prettierd" }, -- YAML formatter
    json = { "prettierd" }, -- JSON formatter

    -- Programming languages
    lua = { "stylua" }, -- Lua formatter
    python = { "ruff" }, -- Python linter/formatter
    go = { "gofumpt" }, -- Go formatter
    golang = { "gofumpt" }, -- Alias for Go
    rust = { "rustfmt" }, -- Rust formatter
    java = { "google-java-format" }, -- Java formatter
    c = { "clang-format" }, -- C formatter
    cpp = { "clang-format" }, -- C++ formatter (optional if needed)
    fish = { "fish_indent" }, -- Fish shell formatter
    nix = { "alejandra", "nixpkgs-fmt" }, -- Nix formatters
  },

  -- Format on save settings
  format_on_save = {
    timeout_ms = 1000, -- Increased timeout for larger files
    lsp_fallback = true, -- Use LSP if no formatter is found
  },
}

return options
