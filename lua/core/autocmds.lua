local aug = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

-- Highlight on yank
aug("YankHighlight", { clear = true })
au("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 120 }
  end,
})

-- Close some windows with q
au("FileType", {
  pattern = { "help", "qf", "lspinfo", "checkhealth" },
  callback = function(ev)
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true })
  end,
})
