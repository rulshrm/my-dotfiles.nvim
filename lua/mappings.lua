require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

-- -- Remap ; to l
-- map("n", ";", "l", { desc = "Move right (remapped from ;)" })
-- map("v", ";", "l", { desc = "Move right (remapped from ;)" })

-- -- Remap l to k
-- map("n", "l", "k", { desc = "Move up (remapped from l)" })
-- map("v", "l", "k", { desc = "Move up (remapped from l)" })

-- -- Remap k to j
-- map("n", "k", "j", { desc = "Move down (remapped from k)" })
-- map("v", "k", "j", { desc = "Move down (remapped from k)" })

-- -- Remap j to h
-- map("n", "j", "h", { desc = "Move left (remapped from j)" })
-- map("v", "j", "h", { desc = "Move left (remapped from j)" })

map("i", "jk", "<ESC>")
map("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
end, { desc = "display inlay hints" })

map("n", "<C-t>", function()
  require("minty.shades").open({ border = false })
end, {})

-- Format keybinding
map("n", "<leader>f", function()
  -- Wrap in pcall to handle any errors
  local status, err = pcall(function()
    -- Gunakan conform.format() daripada lsp.buf.format
    require("conform").format({
      async = true,
      lsp_fallback = true, -- Fallback ke LSP jika tidak ada formatter conform
    })
  end)
  
  if not status then
    vim.notify("Format error: " .. tostring(err), vim.log.levels.ERROR)
  else
    vim.notify("Format successful", vim.log.levels.INFO)
  end
end, { desc = "Format dengan conform.nvim" })

-- Navigate diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

-- Tampilkan diagnostics hanya ketika diperlukan
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

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
map("i", "<Tab>", function()
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

-- Keybindings untuk rest-nvim
map("n", "<leader>rr", "<cmd>RestNvim<CR>", { desc = "Run HTTP Request" })
map("n", "<leader>rp", "<cmd>RestNvimPreview<CR>", { desc = "Preview HTTP Request" })
map("n", "<leader>rl", "<cmd>RestNvimLast<CR>", { desc = "Run Last HTTP Request" })

-- Keybinding untuk refactoring.nvim
map("v", "<leader>re", function()
  require("refactoring").refactor("Extract Function")
end, { desc = "Extract Function" })

map("v", "<leader>rf", function()
  require("refactoring").refactor("Extract Function To File")
end, { desc = "Extract Function to File" })

map("v", "<leader>rv", function()
  require("refactoring").refactor("Extract Variable")
end, { desc = "Extract Variable" })

map("v", "<leader>ri", function()
  require("refactoring").refactor("Inline Variable")
end, { desc = "Inline Variable" })

map("n", "<leader>rb", function()
  require("refactoring").refactor("Extract Block")
end, { desc = "Extract Block" })

map("n", "<leader>rbf", function()
  require("refactoring").refactor("Extract Block To File")
end, { desc = "Extract Block to File" })

-- Wrap related mappings
map("n", "<leader>tw", function()
    vim.wo.wrap = not vim.wo.wrap
    -- Update related options when toggling wrap
    if vim.wo.wrap then
        vim.opt.virtualedit = ""
        vim.notify("Wrap enabled", vim.log.levels.INFO)
    else
        vim.opt.virtualedit = "all"
        vim.notify("Wrap disabled", vim.log.levels.INFO)
    end
end, { desc = "Toggle Wrap" })

-- Better navigation for wrapped lines
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Move down (wrap aware)" })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move up (wrap aware)" })
map("v", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Move down (wrap aware)" })
map("v", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move up (wrap aware)" })

-- End of line navigation in wrapped lines
map("n", "$", "g$", { desc = "End of wrapped line" })
map("n", "0", "g0", { desc = "Start of wrapped line" })
map("v", "$", "g$", { desc = "End of wrapped line" })
map("v", "0", "g0", { desc = "Start of wrapped line" })

-- Laravel specific mappings
map("n", "<leader>la", "<cmd>Artisan<CR>", { desc = "Laravel Artisan" })
map("n", "<leader>lr", "<cmd>Artisan route:list<CR>", { desc = "Laravel Routes" })
map("n", "<leader>lm", "<cmd>Artisan make:", { desc = "Laravel Make" })
map("n", "<leader>lt", "<cmd>Artisan tinker<CR>", { desc = "Laravel Tinker" })
map("n", "<leader>lc", "<cmd>Composer<CR>", { desc = "Composer" })

-- Java specific mappings
local setup_java_maps = function(bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  
  -- Code Actions
  map("n", "<leader>jo", function() require('jdtls').organize_imports() end, 
    vim.tbl_extend("force", opts, { desc = "Organize Imports" }))
  
  -- Testing
  map("n", "<leader>jt", function() require('jdtls').test_class() end,
    vim.tbl_extend("force", opts, { desc = "Test Class" }))
  map("n", "<leader>jn", function() require('jdtls').test_nearest_method() end,
    vim.tbl_extend("force", opts, { desc = "Test Method" }))
  
  -- Debugging
  map("n", "<leader>jb", function() require('dap').toggle_breakpoint() end,
    vim.tbl_extend("force", opts, { desc = "Toggle Breakpoint" }))
  map("n", "<F5>", function() require('dap').continue() end,
    vim.tbl_extend("force", opts, { desc = "Debug: Continue" }))
  
  -- Refactoring
  map("v", "<leader>jem", function() require('jdtls').extract_method(true) end,
    vim.tbl_extend("force", opts, { desc = "Extract Method" }))
  map("v", "<leader>jev", function() require('jdtls').extract_variable(true) end,
    vim.tbl_extend("force", opts, { desc = "Extract Variable" }))

  -- Run Java file
  local java_utils = require('configs.java_utils')

  map("n", "<leader>jr", function()
    -- Save file
    pcall(function() vim.cmd('write!') end)
    
    -- Get paths
    local file_path = vim.fn.expand('%:p')
    local class_name = vim.fn.expand('%:t:r')
    local dir_path = vim.fn.expand('%:p:h')
    
    -- Compile and run
    if not java_utils.compile_and_run(file_path, class_name, dir_path) then
      vim.notify("Failed to run Java file", vim.log.levels.ERROR)
    end
  end, vim.tbl_extend("force", opts, { desc = "Run Java File" }))

  -- Run Java with args
  map("n", "<leader>jR", function()
    vim.ui.input({ prompt = "Arguments: " }, function(args)
      if args then
        -- Simpan file sebelum running
        vim.cmd('write')
        
        -- Get file path dan nama class
        local file_path = vim.fn.expand('%:p')
        local class_name = vim.fn.expand('%:t:r')
        local dir_path = vim.fn.expand('%:p:h')
        
        -- Compile dan run dalam terminal baru
        vim.cmd('split')
        vim.cmd('terminal')
        vim.cmd('startinsert')
        
        -- Compile dan run commands dengan arguments
        local compile_cmd = string.format('javac "%s" && java -cp "%s" %s %s', file_path, dir_path, class_name, args)
        vim.fn.chansend(vim.b.terminal_job_id, compile_cmd .. '\n')
      end
    end)
  end, vim.tbl_extend("force", opts, { desc = "Run Java File with Args" }))
end

-- Create autocmd untuk setup Java mappings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function(ev)
    setup_java_maps(ev.buf)
  end,
})
