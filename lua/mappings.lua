require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- Remap ; to l
map("n", ";", "l", { desc = "Move right (remapped from ;)" })
map("v", ";", "l", { desc = "Move right (remapped from ;)" })

-- Remap l to k
map("n", "l", "k", { desc = "Move up (remapped from l)" })
map("v", "l", "k", { desc = "Move up (remapped from l)" })

-- Remap k to j
map("n", "k", "j", { desc = "Move down (remapped from k)" })
map("v", "k", "j", { desc = "Move down (remapped from k)" })

-- Remap j to h
map("n", "j", "h", { desc = "Move left (remapped from j)" })
map("v", "j", "h", { desc = "Move left (remapped from j)" })

map("i", "jk", "<ESC>")
map("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
end, { desc = "display inlay hints" })

map("n", "<C-t>", function()
  require("minty.shades").open({ border = false })
end, {})

-- Formatting
map("n", "<leader>f", function()
  vim.lsp.buf.format { async = true }
end, { desc = "Format Code" })

-- Navigate diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

-- mouse users + nvimtree users!
vim.keymap.set("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

-- map({ "n", "i", "v" }, "<C-s>", j"<cmd> w <cr>")

-- Navigasi antar tab
map("n", "<Tab>", "<Cmd>BufferNext<CR>", { desc = "Pindah ke tab berikutnya" })
map("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", { desc = "Pindah ke tab sebelumnya" })

-- Menutup tab
map("n", "<leader>tc", "<Cmd>BufferClose<CR>", { desc = "Tutup tab saat ini" })
map("n", "<leader>ba", "<Cmd>BufferCloseAllButCurrent<CR>", { desc = "Tutup semua buffer kecuali yang aktif" })
map("n", "<leader>bl", "<Cmd>BufferCloseBuffersLeft<CR>", { desc = "Tutup semua buffer di kiri" })
map("n", "<leader>br", "<Cmd>BufferCloseBuffersRight<CR>", { desc = "Tutup semua buffer di kanan" })

-- Pindah tab ke posisi tertentu
map("n", "<leader>1", "<Cmd>BufferGoto 1<CR>", { desc = "Pindah ke tab 1" })
map("n", "<leader>2", "<Cmd>BufferGoto 2<CR>", { desc = "Pindah ke tab 2" })
map("n", "<leader>3", "<Cmd>BufferGoto 3<CR>", { desc = "Pindah ke tab 3" })
map("n", "<leader>4", "<Cmd>BufferGoto 4<CR>", { desc = "Pindah ke tab 4" })
map("n", "<leader>5", "<Cmd>BufferGoto 5<CR>", { desc = "Pindah ke tab 5" })
map("n", "<leader>6", "<Cmd>BufferGoto 6<CR>", { desc = "Pindah ke tab 6" })
map("n", "<leader>7", "<Cmd>BufferGoto 7<CR>", { desc = "Pindah ke tab 7" })
map("n", "<leader>8", "<Cmd>BufferGoto 8<CR>", { desc = "Pindah ke tab 8" })
map("n", "<leader>9", "<Cmd>BufferGoto 9<CR>", { desc = "Pindah ke tab 9" })
map("n", "<leader>0", "<Cmd>BufferLast<CR>", { desc = "Pindah ke tab terakhir" })

-- Telescope mappings
map("n", "<leader>ff", "<Cmd>Telescope find_files<CR>", { desc = "Cari File" })
map("n", "<leader>fg", "<Cmd>Telescope live_grep<CR>", { desc = "Cari Teks" })
map("n", "<leader>fb", "<Cmd>Telescope buffers<CR>", { desc = "Cari Buffer" })
map("n", "<leader>fh", "<Cmd>Telescope help_tags<CR>", { desc = "Cari Help" })

-- Window management
map("n", "<leader>ws", "<Cmd>split<CR>", { desc = "Split Horizontal" })
map("n", "<leader>wv", "<Cmd>vsplit<CR>", { desc = "Split Vertikal" })
map("n", "<leader>wh", "<C-w>h", { desc = "Pindah ke Window Kiri" })
map("n", "<leader>wj", "<C-w>j", { desc = "Pindah ke Window Bawah" })
map("n", "<leader>wk", "<C-w>k", { desc = "Pindah ke Window Atas" })
map("n", "<leader>wl", "<C-w>l", { desc = "Pindah ke Window Kanan" })
map("n", "<leader>wq", "<Cmd>close<CR>", { desc = "Tutup Window" })

-- Gitsigns mappings
map("n", "<leader>gs", "<Cmd>Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
map("n", "<leader>gu", "<Cmd>Gitsigns undo_stage_hunk<CR>", { desc = "Undo Stage Hunk" })
map("n", "<leader>gp", "<Cmd>Gitsigns preview_hunk<CR>", { desc = "Preview Hunk" })
map("n", "<leader>gb", "<Cmd>Gitsigns blame_line<CR>", { desc = "Blame Line" })
map("n", "<leader>gr", "<Cmd>Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
map("n", "<leader>gR", "<Cmd>Gitsigns reset_buffer<CR>", { desc = "Reset Buffer" })

-- Keybindings untuk Copilot
map("i", "<C-e>", function()
  vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
end, { desc = "Copilot Accept", silent = true, expr = true })

map("i", "<C-n>", function()
  vim.fn.feedkeys(vim.fn["copilot#Next"](), "")
end, { desc = "Copilot Next Suggestion", silent = true, expr = true })

map("i", "<C-p>", function()
  vim.fn.feedkeys(vim.fn["copilot#Previous"](), "")
end, { desc = "Copilot Previous Suggestion", silent = true, expr = true })

map("i", "<C-d>", function()
  vim.fn.feedkeys(vim.fn["copilot#Dismiss"](), "")
end, { desc = "Copilot Dismiss Suggestion", silent = true, expr = true })

-- Debugging
map("n", "<F5>", function() require("dap").continue() end, { desc = "Start Debugging" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "Step Over" })
map("n", "<F11>", function() require("dap").step_into() end, { desc = "Step Into" })
map("n", "<F12>", function() require("dap").step_out() end, { desc = "Step Out" })
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
map("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "Open Debug REPL" })
