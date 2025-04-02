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
  -- Debug log
  vim.notify("Setting up Mason...", vim.log.levels.INFO)

  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")

  -- Setup Mason
  mason.setup({
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
      keymaps = {
        toggle_server_expand = "<CR>",
        install_server = "i",
        update_server = "u",
        uninstall_server = "x",
      },
    },
    max_concurrent_installers = 10,
    pip = {
      install_args = {},
    },
  })

  -- Setup Mason LSPConfig
  mason_lspconfig.setup({
    ensure_installed = {
      "lua_ls",
      "tsserver",
      "html",
      "cssls",
      "jsonls",
      "yamlls",
    },
    automatic_installation = true,
  })

  -- Configure handlers for LSP servers
  mason_lspconfig.setup_handlers({
    -- Default handler
    function(server_name)
      require("lspconfig")[server_name].setup({
        on_attach = function(client, bufnr)
          -- Disable formatting untuk semua LSP
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false

          -- Notify when LSP attaches
          vim.notify(string.format("LSP %s attached", server_name), vim.log.levels.INFO)
        end,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })
    end,

    -- Special configuration for specific servers
    ["lua_ls"] = function()
      require("lspconfig").lua_ls.setup({
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

    ["tsserver"] = function()
      require("lspconfig").tsserver.setup({
        on_attach = function(client, bufnr)
          -- Disable tsserver formatting
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false

          -- Basic LSP keybindings
          local opts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

          -- Notify when tsserver attaches
          vim.notify("TypeScript LSP attached", vim.log.levels.INFO)
        end,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })
    end,
  })

  -- Install any missing tools
  local registry = require("mason-registry")
  for _, tool in ipairs(M.ensure_installed) do
    if not registry.is_installed(tool) then
      vim.notify(string.format("Installing %s...", tool), vim.log.levels.INFO)
      registry.get_package(tool):install()
    end
  end

  vim.notify("Mason setup completed!", vim.log.levels.INFO)
end

return M