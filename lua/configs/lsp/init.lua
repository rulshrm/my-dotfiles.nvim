local M = {}

-- Capabilities (cmp)
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

-- Diagnostics: ramah performa dan minim distraksi
vim.diagnostic.config {
  update_in_insert = false,
  virtual_text = false,
  signs = true,
  underline = true,
  severity_sort = true,
  float = { border = "rounded", source = "always", max_width = 100 },
}

local on_attach = function(client, bufnr)
  -- Nonaktifkan formatting di server tertentu bila pakai formatter eksternal
  if client.name == "tsserver" or client.name == "vtsls" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
  map("n", "gr", vim.lsp.buf.references, "References")
  map("n", "K", vim.lsp.buf.hover, "Hover")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map("n", "<leader>ih", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }, { bufnr = bufnr })
  end, "Toggle Inlay Hints")

  vim.notify(string.format("LSP %s attached (buf %d)", client.name, bufnr), vim.log.levels.INFO)
end

function M.setup()
  -- Mason
  require("mason").setup()
  local mason_lspconfig = require "mason-lspconfig"

  mason_lspconfig.setup {
    ensure_installed = {
      "lua_ls",
      "tsserver",
      "html",
      "cssls",
      "jsonls",
      "marksman",
      "pyright",
      "gopls",
      "intelephense",
    },
  }

  local lspconfig = require "lspconfig"

  -- Lua
  lspconfig.lua_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  }

  -- TypeScript / JavaScript (tsserver) dengan preferensi auto-import
  lspconfig.tsserver.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      typescript = {
        preferences = {
          includeCompletionsForModuleExports = true,
          includeCompletionsWithInsertText = true,
          includePackageJsonAutoImports = "on",
          importModuleSpecifierPreference = "non-relative",
          importModuleSpecifierEnding = "auto",
        },
        suggest = { autoImports = true, completeFunctionCalls = true },
      },
      javascript = {
        preferences = {
          includeCompletionsForModuleExports = true,
          includeCompletionsWithInsertText = true,
          includePackageJsonAutoImports = "on",
          importModuleSpecifierPreference = "non-relative",
          importModuleSpecifierEnding = "auto",
        },
        suggest = { autoImports = true, completeFunctionCalls = true },
      },
    },
  }

  -- HTML/CSS/JSON/Markdown/Python/Go/PHP
  lspconfig.html.setup { capabilities = capabilities, on_attach = on_attach }
  lspconfig.cssls.setup { capabilities = capabilities, on_attach = on_attach }
  lspconfig.jsonls.setup { capabilities = capabilities, on_attach = on_attach }
  lspconfig.marksman.setup { capabilities = capabilities, on_attach = on_attach }
  lspconfig.pyright.setup { capabilities = capabilities, on_attach = on_attach }
  lspconfig.gopls.setup { capabilities = capabilities, on_attach = on_attach }
  lspconfig.intelephense.setup { capabilities = capabilities, on_attach = on_attach }
end

return M
