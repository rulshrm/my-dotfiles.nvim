local M = {}

-- Cache capabilities
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

-- Optimize diagnostics
vim.diagnostic.config({
  update_in_insert = false,    -- Disable diagnostics in insert mode
  virtual_text = false,        -- Disable virtual text
  signs = true,               -- Show signs
  underline = true,           -- Show underlines
  severity_sort = true,       -- Sort by severity
  float = {
    border = "rounded",
    source = "always",
  },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    update_in_insert = false,
    severity_sort = true,
    underline = true,
    virtual_text = false,  -- Sudah diatur di diagnostic.config
  }
)

local on_attach = function(client, bufnr)
  -- Disable formatting for tsserver as we'll use null-ls/prettierd
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  -- Keybindings untuk LSP
  local buf_map = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  buf_map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
  buf_map("n", "gr", vim.lsp.buf.references, { desc = "Go to References" })
  buf_map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
  buf_map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
  buf_map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

  -- Notify when LSP attaches
  vim.notify(string.format("LSP %s attached to buffer %d", client.name, bufnr), vim.log.levels.INFO)
end

M.setup = function()
  local lspconfig = require("lspconfig")

  -- TypeScript setup
  lspconfig.ts_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
    single_file_support = true,
  })

  -- Default LSP setup
  local servers = {
    "lua_ls",
    "html",
    "cssls",
    "jsonls",
    "yamlls",
    "vimls",
    "rust_analyzer",
    "gopls",
    "nimls",
  }

  for _, server in ipairs(servers) do
    lspconfig[server].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end

  -- Custom configuration for specific LSPs
  lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
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

  lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        inlayHints = {
          chainingHints = { enable = true },
          closingBraceHints = { enable = true, minLines = 25 },
          parameterHints = { enable = true },
          typeHints = { enable = true },
        },
      },
    },
  })
end

return M
