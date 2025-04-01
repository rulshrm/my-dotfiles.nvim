local M = {}

local on_attach = function(client, bufnr)
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
  buf_map("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, { desc = "Format Code" })

  -- Highlight symbol under cursor
  if client.server_capabilities.document_highlight then
    vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

M.setup = function()
  local lspconfig = require("lspconfig")

  -- Default LSP setup
  local servers = {
    "lua_ls",
    "html",
    "cssls",
    "ts_ls",
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
  lspconfig.ts_ls.setup({
    on_attach = function(client, bufnr)
      -- Disable formatting for ts_ls
      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  })

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
