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

  local lspconfig_status, lspconfig = pcall(require, "lspconfig")
  if not lspconfig_status then
    vim.notify("nvim-lspconfig not found!", vim.log.levels.ERROR)
    return
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
      -- Add other LSPs you use here
    },

    handlers = {
      function(server_name)
        lspconfig[server_name].setup({})
      end,

      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
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
        lspconfig.tsserver.setup({
          -- Add any tsserver specific settings here
        })
      end,

      ["eslint"] = function()
        lspconfig.eslint.setup({
           -- ESLint specific settings
        })
      end,
    },
  })
end

return M