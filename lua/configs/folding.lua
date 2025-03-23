-- ~/.config/nvim/lua/configs/folding.lua

-- Enable folding based on indentation.
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99

-- Key mappings for folding
vim.api.nvim_set_keymap('n', 'zc', ':foldclose<CR>', { noremap = true, silent = true })       -- Menutup fold di bawah kursor
vim.api.nvim_set_keymap('n', 'zo', ':foldopen<CR>', { noremap = true, silent = true })        -- Membuka fold di bawah kursor
vim.api.nvim_set_keymap('n', 'za', ':fold<CR>', { noremap = true, silent = true })            -- Toggle fold di bawah kursor
vim.api.nvim_set_keymap('n', 'zM', ':foldcloseall<CR>', { noremap = true, silent = true })    -- Menutup semua fold
vim.api.nvim_set_keymap('n', 'zR', ':foldopenall<CR>', { noremap = true, silent = true })     -- Membuka semua fold
