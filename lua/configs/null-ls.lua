-- filepath ~/.config/nvim/lua/configs/null-ls.lua
local null_ls = require("null-ls")
local notify = vim.notify

local M = {}

M.setup = function()
  -- Debug log
  print("Setting up null-ls...")

  -- Verifikasi prettierd terinstall
  if vim.fn.executable("prettierd") ~= 1 then
    notify("prettierd not found. Please install it via Mason", vim.log.levels.ERROR)
    return
  end

  -- Register sources
  local sources = {
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
  }

  null_ls.setup({
    debug = true, -- Enable debug mode
    sources = sources,
    on_attach = function(client, bufnr)
      -- Debug log
      print(string.format("null-ls attaching to buffer %d", bufnr))
      
      if client.supports_method("textDocument/formatting") then
        -- Notify when null-ls attaches to buffer
        notify(string.format("null-ls attached to buffer %d", bufnr), vim.log.levels.INFO)
        
        -- Set formatting keymap
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({
            async = true,
            filter = function(c)
              return c.name == "null-ls"
            end,
          })
        end, { buffer = bufnr, desc = "Format with null-ls" })

        -- Set up format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              async = false,
              filter = function(c)
                return c.name == "null-ls"
              end,
            })
          end,
        })
      end
    end,
  })

  -- Debug log
  print("null-ls setup completed!")
end

return M