local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "gopls", "zls", "rust_analyzer", "nimls", "ltex", "fortls", "ts_ls", "jdtls", "ruby_lsp", "ruff" }

-- Default LSP setup with error handling
for _, lsp in ipairs(servers) do
  if lspconfig[lsp] then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    }
  else
    print("Warning: LSP server " .. lsp .. " is not installed.")
  end
end

-- TypeScript LSP with formatting disabled
lspconfig.ts_ls.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = false -- Disable formatting
  end,
  on_init = on_init,
  capabilities = capabilities,
}

-- Rust Analyzer with custom inlay hints
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  on_init = on_init,
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
}

-- Clangd with fallback flags and inlay hints
lspconfig.clangd.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    clangd = {
      fallbackFlags = { "-std=c++20" },
    },
  },
}

-- Lua LSP with dynamic workspace paths
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    Lua = {
      hint = {
        enable = true,
        arrayIndex = "Disable",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
        },
      },
    },
  },
}
