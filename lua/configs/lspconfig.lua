local M = {}

-- Try to be compatible with the new LSP registry (Neovim 0.11+) and fallback to classic lspconfig
local legacy_lspconfig
local legacy_checked = false

local function resolve_server(server)
  local registry = rawget(vim.lsp, "config")

  if registry ~= nil then
    if type(registry) == "table" and registry[server] then
      return registry[server]
    end

    if type(registry) == "function" then
      local ok, config = pcall(registry, server)
      if ok and config then
        return config
      end
    end

    return nil
  end

  if not legacy_checked then
    local ok, legacy = pcall(require, "lspconfig")
    legacy_lspconfig = ok and legacy or nil
    legacy_checked = true
  end

  if legacy_lspconfig and legacy_lspconfig[server] then
    return legacy_lspconfig[server]
  end
end

local function setup_server(server, opts)
  local config = resolve_server(server)

  if config and type(config.setup) == "function" then
    config.setup(opts or {})
    return
  end

  -- Neovim 0.11+ API (vim.lsp.config + vim.lsp.enable)
  if config and type(config) == "table" and config.cmd then
    local merged = vim.tbl_deep_extend("force", config, opts or {})
    vim.lsp.start(merged)
    return
  end

  vim.notify(("LSP server '%s' could not be configured."):format(server), vim.log.levels.WARN)
end

-- Capabilities (nvim-cmp)
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  (pcall(require, "cmp_nvim_lsp") and require("cmp_nvim_lsp").default_capabilities() or {})
)

-- Diagnostics yang bersih
vim.diagnostic.config {
  update_in_insert = false,
  virtual_text = false,
  signs = true,
  underline = true,
  severity_sort = true,
  float = { border = "rounded", source = "always", max_width = 100 },
}

local on_attach = function(client, bufnr)
  -- Disable formatting in TS when using external formatter
  if client.name == "tsserver" or client.name == "ts_ls" then
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

  -- Toggle inlay hints
  map("n", "<leader>ih", function()
    local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
    vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
  end, "Toggle Inlay Hints")

  vim.notify(string.format("LSP %s attached (buf %d)", client.name, bufnr), vim.log.levels.INFO)
end

function M.setup()
  -- Lua
  setup_server("lua_ls", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  })

  -- TypeScript/JavaScript (mason memastikan "ts_ls"; jaga kompatibel juga dengan "tsserver")
  local ts_settings = {
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
  setup_server("ts_ls", ts_settings)
  setup_server("tsserver", ts_settings)

  -- HTML/CSS/JSON/Markdown/Python/Go/PHP, dsb.
  setup_server("html", { capabilities = capabilities, on_attach = on_attach })
  setup_server("cssls", { capabilities = capabilities, on_attach = on_attach })
  setup_server("jsonls", { capabilities = capabilities, on_attach = on_attach })
  setup_server("marksman", { capabilities = capabilities, on_attach = on_attach })
  setup_server("pyright", { capabilities = capabilities, on_attach = on_attach })
  setup_server("gopls", { capabilities = capabilities, on_attach = on_attach })
  setup_server("intelephense", { capabilities = capabilities, on_attach = on_attach })
  setup_server("eslint", { capabilities = capabilities, on_attach = on_attach })
  setup_server("yamlls", { capabilities = capabilities, on_attach = on_attach })
  setup_server("tailwindcss", { capabilities = capabilities, on_attach = on_attach })
  setup_server("emmet_ls", { capabilities = capabilities, on_attach = on_attach })
end

return M
