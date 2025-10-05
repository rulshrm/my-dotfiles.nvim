local lspconfig = require "lspconfig"

-- Kemampuan LSP + cmp
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

local function on_attach(client, bufnr)
  -- Kalau Anda pakai formatter eksternal, nonaktifkan formatting tsserver
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
end

lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  -- Penting: preferensi untuk auto import dan gaya import
  settings = {
    typescript = {
      preferences = {
        includeCompletionsForModuleExports = true,
        includeCompletionsWithInsertText = true,
        includePackageJsonAutoImports = "on",
        importModuleSpecifierPreference = "non-relative",
        importModuleSpecifierEnding = "auto",
      },
      suggest = {
        completeFunctionCalls = true,
        autoImports = true,
      },
      inlayHints = { includeInlayVariableTypeHintsWhenTypeMatchesName = false },
    },
    javascript = {
      preferences = {
        includeCompletionsForModuleExports = true,
        includeCompletionsWithInsertText = true,
        includePackageJsonAutoImports = "on",
        importModuleSpecifierPreference = "non-relative",
        importModuleSpecifierEnding = "auto",
      },
      suggest = {
        completeFunctionCalls = true,
        autoImports = true,
      },
    },
  },
}
