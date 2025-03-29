local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    -- Prettierd for formatting
    null_ls.builtins.formatting.prettierd.with({
      filetypes = { "javascript", "typescript", "typescriptreact", "json", "yaml", "markdown", "html", "css", "scss" },
      extra_args = {
        "--print-width", "80",               -- Maksimal panjang baris
        "--tab-width", "2",                  -- Gunakan indentasi 2 spasi
        "--semi", "true",                    -- Tambahkan titik koma di akhir pernyataan
        "--trailing-comma", "es5",           -- Tambahkan koma trailing untuk ES5
        "--bracket-same-line", "false",      -- Jangan letakkan `>` di baris yang sama
        "--single-quote", "false",           -- Gunakan tanda kutip ganda
        "--single-attribute-per-line", "true" -- Bungkus setiap atribut JSX/TSX ke baris baru
      },
    }),

    -- ESLint for diagnostics and code actions
    null_ls.builtins.diagnostics.eslint_d.with({
      filetypes = { "javascript", "typescript", "typescriptreact" },
    }),
    null_ls.builtins.code_actions.eslint_d,
  },

  -- Auto-format on save
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = false })
        end,
      })
    end
  end,
})
