local M = {}

-- Daftar alat yang akan diinstal oleh Mason
M.ensure_installed = {
  -- LSPs
  "lua_ls",                   -- Lua LSP
  "html",                     -- HTML LSP
  "cssls",                    -- CSS LSP
  "tsserver",                 -- TypeScript/JavaScript LSP
  "jsonls",                   -- JSON LSP
  "yamlls",                   -- YAML LSP
  "vimls",                    -- Vimscript LSP
  "rust_analyzer",            -- Rust LSP
  "gopls",                    -- Go LSP
  "nimls",                    -- Nim LSP

  -- Formatters
  "prettierd",                -- Prettier daemon
  "stylua",                   -- Lua formatter
  "rustfmt",                  -- Rust formatter
  "shfmt",                    -- Shell script formatter
  "black",                    -- Python formatter

  -- Linters
  "eslint_d",                 -- ESLint daemon for JS/TS
  "ruff",                     -- Python linter/formatter
  "shellcheck",               -- Shell script linter
  "hadolint",                 -- Dockerfile linter
}

M.setup = function()
  print("Setting up Mason...") -- Tambahkan log untuk debugging
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local mason_registry = require("mason-registry")

  -- Auto-install missing tools
  for _, tool in ipairs(M.ensure_installed) do
    local ok, package = pcall(mason_registry.get_package, tool)
    if ok then
      if not package:is_installed() then
        vim.notify("Installing " .. tool .. "...", vim.log.levels.INFO)
        package:install()
      end
    else
      vim.notify("Package " .. tool .. " not found in Mason registry.", vim.log.levels.ERROR)
    end
  end

  -- Setup Mason
  mason.setup({
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })

  -- Setup Mason LSPConfig
  mason_lspconfig.setup({
    ensure_installed = M.ensure_installed,
    automatic_installation = true, -- Install LSPs automatically
  })

  print("Mason setup completed!") -- Tambahkan log untuk debugging

  -- Configure LSP servers
  mason_lspconfig.setup_handlers({
    function(server_name)
      require("lspconfig")[server_name].setup({
        on_attach = require("nvchad.configs.lspconfig").on_attach,
        capabilities = require("nvchad.configs.lspconfig").capabilities,
      })
    end,
    -- Custom configuration for specific LSPs
    ["tsserver"] = function()
      require("lspconfig").tsserver.setup({
        on_attach = function(client, bufnr)
          -- Disable formatting for tsserver
          client.server_capabilities.document_formatting = false
          client.server_capabilities.document_range_formatting = false
        end,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })
    end,
    ["lua_ls"] = function()
      require("lspconfig").lua_ls.setup({
        on_attach = require("nvchad.configs.lspconfig").on_attach,
        capabilities = require("nvchad.configs.lspconfig").capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                vim.fn.expand("$VIMRUNTIME/lua"),
                vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
              },
            },
          },
        },
      })
    end,
  })
end

return M