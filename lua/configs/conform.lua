-- Configuration for Conform.nvim
local options = {
  -- Formatters grouped by filetype
  formatters_by_ft = {
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

    -- Web development
    html = { "prettier" }, -- HTML formatter
    css = { "prettier", "prettierd" }, -- CSS formatter
    javascript = { "prettierd" }, -- JavaScript formatter (daemon)
    javascriptreact = { "prettier" }, -- React (JSX) formatter
    typescript = { "prettier" }, -- TypeScript formatter
    typescriptreact = { "prettier" }, -- React (TSX) formatter
    svelte = { "prettier" }, -- Svelte formatter

    -- Markup and configuration files
    markdown = { "prettier", "prettierd" }, -- Markdown formatter
    yaml = { "prettier" }, -- YAML formatter
    json = { "prettier" }, -- JSON formatter
  },

  -- Format on save settings
  format_on_save = {
    timeout_ms = 1000, -- Increased timeout for larger files
    lsp_fallback = true, -- Use LSP if no formatter is found
  },
}

return options
