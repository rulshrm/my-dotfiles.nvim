local M = {}

function M.setup()
  local mason_status, mason = pcall(require, "mason")
  if not mason_status then
    vim.notify("mason.nvim not found!", vim.log.levels.ERROR)
    return
  end

  local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not mason_lspconfig_status then
    vim.notify("mason-lspconfig.nvim not found!", vim.log.levels.ERROR)
    return
  end

  local registry = rawget(vim.lsp, "config")
  if registry == nil then
    local ok = pcall(require, "lspconfig")
    if not ok then
      vim.notify("nvim-lspconfig not found!", vim.log.levels.ERROR)
      return
    end
  end

  mason.setup({
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
    -- log_level = vim.log.levels.DEBUG, -- Uncomment for debugging
  })

  local setup_server = require("configs.lspconfig").setup_server
  mason_lspconfig.setup({
    ensure_installed = {
      "lua_ls",
      "ts_ls",
      "eslint",
      "jsonls",
      "html",
      "cssls",
      "tailwindcss",
      "marksman",
      "jdtls", -- Java language server
      -- Add other LSPs you use here
    },

    handlers = {
      function(server_name)
        setup_server(server_name, {})
      end,

      ["lua_ls"] = function()
        setup_server("lua_ls", {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        })
      end,
      
      ["tsserver"] = function()
        setup_server("tsserver", {
          -- Add any tsserver specific settings here
        })
      end,

      ["eslint"] = function()
        setup_server("eslint", {
           -- ESLint specific settings
        })
      end,
    },
  })
end

return M