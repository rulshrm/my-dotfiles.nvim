local M = {}

M.setup = function()
  -- Kustomisasi vim-visual-multi
  vim.g.VM_theme = 'ocean'
  vim.g.VM_highlight_matches = 'underline'
  vim.g.VM_maps = {
    ["Find Under"] = "<C-d>",           -- Pilih kata di bawah kursor
    ["Find Subword Under"] = "<C-d>",   -- Sama seperti di atas
    ["Select All"] = "<C-a>",           -- Pilih semua kata
    ["Visual All"] = "<C-a>",           -- Sama seperti di atas
    ["Skip Region"] = "<C-x>",          -- Lewati region saat ini
    ["Remove Region"] = "<C-p>",        -- Hapus region saat ini
    ["Undo"] = "u",                     -- Undo
    ["Redo"] = "<C-r>",                -- Redo
  }
  
  vim.g.VM_custom_selector = {
    ['ia'] = '<Plug>(VM-Visual-Inner-Argument)', -- Dalam argumen
    ['aa'] = '<Plug>(VM-Visual-All-Argument)',   -- Semua argumen
    ['if'] = '<Plug>(VM-Visual-Inner-Function)', -- Dalam fungsi
  }
  
  -- Status line format
  vim.g.VM_set_statusline = 2
end

return M