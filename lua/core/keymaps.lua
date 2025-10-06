local map = vim.keymap.set

-- General
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })

-- Diagnostics
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Formatting (Conform)
map({ "n", "v" }, "<leader>f", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format file/range" })
