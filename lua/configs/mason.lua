local M = {}

M.ensure_installed = {
  -- LSPs
  "lua-language-server",        -- Lua LSP
  "html-lsp",                   -- HTML LSP
  "css-lsp",                    -- CSS LSP
  "typescript-language-server", -- TypeScript/JavaScript LSP
  "json-languageserver",        -- JSON LSP
  "yaml-language-server",       -- YAML LSP
  "vimls",                      -- Vimscript LSP
  "rust_analyzer",              -- Rust LSP
  "gopls",                      -- Go LSP
  "nimls",                      -- Nim LSP

  -- Formatters
  "prettierd",          -- Prettier daemon
  "stylua",             -- Lua formatter
  "rustfmt",            -- Rust formatter
  "google-java-format", -- Java formatter
  "clang-format",       -- C/C++ formatter
  "alejandra",          -- Nix formatter
  "nixpkgs-fmt",        -- Nix formatter
  "fish_indent",        -- Fish shell formatter
  "shfmt",              -- Shell script formatter
  "black",              -- Python formatter

  -- Linters
  "eslint_d",    -- ESLint daemon for JS/TS
  "ruff",        -- Python linter/formatter
  "shellcheck",  -- Shell script linter
  "hadolint",    -- Dockerfile linter
}

M.setup = function()
  local mason = require("mason")
  local mason_registry = require("mason-registry")

  -- Auto-install missing tools
  for _, tool in ipairs(M.ensure_installed) do
    local package = mason_registry.get_package(tool)
    if not package:is_installed() then
      vim.notify("Installing " .. tool .. "...", vim.log.levels.INFO)
      package:install()
    end
  end

  mason.setup()
end

return M