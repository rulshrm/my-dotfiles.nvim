local M = {}

M.setup = function()
  require("which-key").setup {
    plugins = {
      marks = true, -- Tampilkan marks
      registers = true, -- Tampilkan registers
      spelling = {
        enabled = true, -- Aktifkan saran ejaan
        suggestions = 20, -- Jumlah saran ejaan
      },
    },
    replace = { -- Gantikan `key_labels` dengan `replace`
      ["<leader>"] = "SPC", -- Tampilkan <leader> sebagai "SPC"
      ["<CR>"] = "RET",
      ["<Tab>"] = "TAB",
    },
    win = { -- Gantikan `window` dengan `win`
      border = "rounded", -- Gunakan border bulat
      position = "bottom", -- Tampilkan di bagian bawah
      margin = { 1, 0, 1, 0 }, -- Margin di sekitar popup
      padding = { 2, 2, 2, 2 }, -- Padding di dalam popup
    },
    layout = {
      height = { min = 4, max = 25 }, -- Tinggi minimum dan maksimum
      width = { min = 20, max = 50 }, -- Lebar minimum dan maksimum
      spacing = 3, -- Spasi antar kolom
      align = "center", -- Rata tengah
    },
    ignore_missing = true, -- Abaikan keybinding yang tidak ada
    show_help = true, -- Tampilkan bantuan di popup
  }

  local wk = require("which-key")

  wk.register({
    ["<leader>f"] = { name = "Find" },
    ["<leader>fb"] = { "<Cmd>Telescope buffers<CR>", "Find Buffers" },
    ["<leader>ff"] = { "<Cmd>Telescope find_files<CR>", "Find Files" },
    ["<leader>fg"] = { "<Cmd>Telescope live_grep<CR>", "Live Grep" },
    ["<leader>fh"] = { "<Cmd>Telescope help_tags<CR>", "Find Help" },

    ["<leader>g"] = { name = "Git" },
    ["<leader>gR"] = { "<Cmd>Gitsigns reset_buffer<CR>", "Reset Buffer" },
    ["<leader>gb"] = { "<Cmd>Gitsigns blame_line<CR>", "Blame Line" },
    ["<leader>gp"] = { "<Cmd>Gitsigns preview_hunk<CR>", "Preview Hunk" },
    ["<leader>gr"] = { "<Cmd>Gitsigns reset_hunk<CR>", "Reset Hunk" },
    ["<leader>gs"] = { "<Cmd>Gitsigns stage_hunk<CR>", "Stage Hunk" },
    ["<leader>gu"] = { "<Cmd>Gitsigns undo_stage_hunk<CR>", "Undo Stage Hunk" },

    ["<leader>w"] = { name = "Window" },
    ["<leader>wh"] = { "<C-w>h", "Move to Left Window" },
    ["<leader>wj"] = { "<C-w>j", "Move to Bottom Window" },
    ["<leader>wk"] = { "<C-w>k", "Move to Top Window" },
    ["<leader>wl"] = { "<C-w>l", "Move to Right Window" },
    ["<leader>wq"] = { "<Cmd>close<CR>", "Close Window" },
    ["<leader>ws"] = { "<Cmd>split<CR>", "Split Horizontal" },
    ["<leader>wv"] = { "<Cmd>vsplit<CR>", "Split Vertical" },
  })

  wk.register({
    ["<leader>c"] = {
      name = "Copilot",
      c = { "<cmd>CopilotChat<CR>", "Open Chat" },
      e = { "<cmd>CopilotChatExplain<CR>", "Explain Code" },
      t = { "<cmd>CopilotChatTests<CR>", "Generate Tests" },
      r = { "<cmd>CopilotChatReview<CR>", "Review Code" },
      f = { "<cmd>CopilotChatRefactor<CR>", "Refactor Code" },
      d = { "<cmd>CopilotChatDocumentation<CR>", "Generate Documentation" },
      b = { "<cmd>CopilotChatFixBug<CR>", "Fix Bugs" },
      o = { "<cmd>CopilotChatOptimize<CR>", "Optimize Code" },
    },
  })

  wk.register({
    ["<leader>t"] = {
      name = "Toggle",
      w = { "<cmd>lua vim.wo.wrap = not vim.wo.wrap<CR>", "Toggle Wrap" },
    },
  })
end

return M
