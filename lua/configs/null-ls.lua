-- filepath ~/.config/nvim/lua/configs/null-ls.lua
-- Apply patches before loading null-ls
require("configs.null-ls-patch").apply_patches()

local null_ls = require("null-ls")
local notify = vim.notify

local M = {}

M.setup = function()
  notify("Setting up null-ls...", vim.log.levels.INFO)

  -- Ini akan memastikan bahwa _request_name_to_capability sudah diinisialisasi
  null_ls.setup({
    debug = true,
    on_init = function(client)
      -- Ensure field exists before any operations
      client._request_name_to_capability = client._request_name_to_capability or {}
    end,
    sources = {
      -- Formatting sources
      null_ls.builtins.formatting.prettierd.with({
        filetypes = {
          "javascript", "typescript", "javascriptreact", "typescriptreact",
          "json", "css", "html", "yaml", "markdown",
        },
      }),
      null_ls.builtins.formatting.phpcsfixer,
      null_ls.builtins.formatting.blade_formatter,
      
      -- Linting sources
      null_ls.builtins.diagnostics.eslint_d.with({
        condition = function(utils)
          return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json" })
        end,
      }),
      null_ls.builtins.diagnostics.php,
      null_ls.builtins.diagnostics.phpcs.with({
        extra_args = {
          "--standard=PSR12",
        },
      }),
    },
    
    on_attach = function(client, bufnr)
      -- Double ensure field exists
      client._request_name_to_capability = client._request_name_to_capability or {}
      
      notify(string.format("null-ls attached to buffer %d", bufnr), vim.log.levels.INFO)
      
      -- Auto-format on save
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              async = false,
              timeout_ms = 2000,
              filter = function(c)
                return c.name == "null-ls"
              end,
            })
          end,
        })
      end
    end,
  })

  notify("null-ls setup completed!", vim.log.levels.INFO)
end

return M