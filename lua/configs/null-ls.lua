-- filepath ~/.config/nvim/lua/configs/null-ls.lua
local null_ls = require("null-ls")
local notify = vim.notify

local M = {}

M.setup = function()
  -- Debug log
  notify("Setting up null-ls...", vim.log.levels.INFO)

  -- Verifikasi prettierd terinstall
  if vim.fn.executable("prettierd") ~= 1 then
    notify("prettierd not found. Please install it via Mason", vim.log.levels.ERROR)
    return
  end

  -- Setup null-ls
  null_ls.setup({
    debug = true,
    sources = {
      -- Formatting
      null_ls.builtins.formatting.prettierd.with({
        filetypes = {
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "json",
          "css",
          "html",
          "yaml",
          "markdown"
        },
      }),
      
      -- Linting
      null_ls.builtins.diagnostics.eslint_d.with({
        condition = function(utils)
          return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json" })
        end,
      }),
    },
    
    -- Perbaiki on_attach handler
    on_attach = function(client, bufnr)
      -- Debug log
      notify(string.format("null-ls attaching to buffer %d", bufnr), vim.log.levels.INFO)
      
      -- Format on save
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