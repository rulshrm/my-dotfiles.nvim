local mason_registry = require("mason-registry")
local conform = require("conform")

-- Ensure all formatters and linters are installed
local tools = {
  "stylua",              -- Lua formatter
  "ruff",                -- Python linter/formatter
  "gofumpt",             -- Go formatter
  "prettier",            -- Prettier for formatting
  "prettierd",           -- Prettier daemon
  "rustfmt",             -- Rust formatter
  "google-java-format",  -- Java formatter
  "clang-format",        -- C/C++ formatter
  "alejandra",           -- Nix formatter
  "nixpkgs-fmt",         -- Nix formatter
  "fish_indent",         -- Fish shell formatter
}

for _, tool in ipairs(tools) do
  local package = mason_registry.get_package(tool)
  if not package:is_installed() then
    print("Installing " .. tool .. "...")
    package:install()
  end
end

-- Configure Conform to use the installed tools
conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff" },
    go = { "gofumpt" },
    html = { "prettier" },
    css = { "prettier", "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    rust = { "rustfmt" },
    java = { "google-java-format" },
    c = { "clang-format" },
    nix = { "alejandra", "nixpkgs-fmt" },
    fish = { "fish_indent" },
    svelte = { "prettier" },
    markdown = { "prettier", "prettierd" },
    yaml = { "prettier" },
    json = { "prettier" },
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
  },
})