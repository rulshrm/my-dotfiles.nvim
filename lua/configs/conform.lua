local mason_registry = require("mason-registry")

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
    vim.notify("Installing " .. tool .. "...", vim.log.levels.INFO)
    package:install()
  end
end

-- Configuration for Conform.nvim
local conform = require("conform")

conform.setup({
  -- Formatters grouped by filetype
  formatters_by_ft = setmetatable({
    -- Web development
    html = { "prettierd" }, -- HTML formatter
    css = { "prettierd" }, -- CSS formatter
    javascript = { "prettierd" }, -- JavaScript formatter (daemon)
    javascriptreact = { "prettierd" }, -- React (JSX) formatter
    typescript = { "prettierd" }, -- TypeScript formatter
    typescriptreact = { "prettierd" }, -- React (TSX) formatter
    svelte = { "prettierd" }, -- Svelte formatter
    vue = { "prettierd" }, -- Vue formatter
    astro = { "prettierd" }, -- Astro formatter

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
    cpp = { "clang-format" }, -- C++ formatter
    fish = { "fish_indent" }, -- Fish shell formatter
    nix = { "alejandra", "nixpkgs-fmt" }, -- Nix formatters
  }, {
    -- Fallback formatter for unknown filetypes
    __index = function()
      return { "prettierd" }
    end,
  }),

  -- Format on save settings
  format_on_save = {
    timeout_ms = 2000, -- Timeout for formatting
    lsp_fallback = true, -- Use LSP formatting if no formatter is configured
  },
})
