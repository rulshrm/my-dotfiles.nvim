local null_ls = require("null-ls")

local M = {}

M.setup = function()
  null_ls.setup({
    sources = {
      -- Formatter
      null_ls.builtins.formatting.prettierd.with({
        filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "css", "html", "yaml", "markdown" },
      }),
      -- Linter
      null_ls.builtins.diagnostics.eslint_d.with({
        condition = function(utils)
          return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc.json")
        end,
      }),
    },
    on_attach = function(client, bufnr)
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { noremap = true, silent = true })
      end
    end,
  })
end

return M