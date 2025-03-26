local null_ls = require "null-ls"

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.prettierd.with {
      filetypes = { "javascript", "typescript", "typescriptreact", "json", "yaml", "markdown", "html", "css", "scss" },
      extra_args = {
        "--single-quote", "false", -- Gunakan tanda kutip ganda
        "--trailing-comma", "es5", -- Tambahkan koma trailing untuk ES5
        "--tab-width", "2",      -- Gunakan indentasi 2 spasi
        "--semi", "true",        -- Tambahkan titik koma di akhir pernyataan
        "--print-width", "80",   -- Maksimal panjang baris 80 karakter
      },
    },
    null_ls.builtins.diagnostics.eslint_d.with {
      filetypes = { "javascript", "typescript", "typescriptreact" },
    },
    null_ls.builtins.code_actions.eslint_d, -- Tambahkan code actions untuk ESLint
  },
}