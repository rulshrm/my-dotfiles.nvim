local mason_registry = require("mason-registry")
local conform = require("conform")

-- Ensure all formatters and linters are installed
local tools = {
  "stylua",              -- Lua formatter
  "ruff",                -- Python linter/formatter
  "gofumpt",             -- Go formatter
  "prettierd",           -- Prettier daemon (optimized for web development)
  "rustfmt",             -- Rust formatter
  "google-java-format",  -- Java formatter
  "clang-format",        -- C/C++ formatter
  "alejandra",           -- Nix formatter
  "nixpkgs-fmt",         -- Nix formatter
  "fish_indent",         -- Fish shell formatter
}

-- Install tools if not already installed
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
    -- Web development
    html = { "prettierd" },
    css = { "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    svelte = { "prettierd" },
    markdown = { "prettierd" },
    yaml = { "prettierd" },
    json = { "prettierd" },

    -- Other languages
    lua = { "stylua" },
    python = { "ruff" },
    go = { "gofumpt" },
    rust = { "rustfmt" },
    java = { "google-java-format" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    nix = { "alejandra", "nixpkgs-fmt" },
    fish = { "fish_indent" },
  },

  -- Format on save settings
  format_on_save = {
    timeout_ms = 1000, -- Timeout for formatting
    lsp_fallback = true, -- Use LSP formatting if no formatter is configured
  },
})