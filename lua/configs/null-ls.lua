local null_ls = require "null-ls"

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.prettier.with {
      filetypes = { "javascript", "typescript", "typescriptreact", "json", "yaml", "markdown", "html", "css", "scss" },
    },
    null_ls.builtins.diagnostics.eslint_d.with {
      filetypes = { "javascript", "typescript", "typescriptreact" },
    },
    null_ls.builtins.code_actions.eslint_d, -- Tambahkan code actions untuk ESLint
  },
}