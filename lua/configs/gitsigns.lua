return {
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  numhl = false, -- Nonaktifkan nomor baris dengan highlight
  linehl = false, -- Nonaktifkan highlight baris
  watch_gitdir = {
    interval = 1000, -- Interval untuk memeriksa perubahan di direktori Git
  },
  current_line_blame = true, -- Tampilkan blame di baris saat ini
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- Tampilkan blame di akhir baris
    delay = 1000, -- Tunda sebelum menampilkan blame
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  sign_priority = 6, -- Prioritas tanda
  update_debounce = 200, -- Tunda pembaruan
  status_formatter = nil, -- Gunakan formatter bawaan
  max_file_length = 40000, -- Nonaktifkan untuk file besar

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    -- Navigation
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true, buffer=bufnr})

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true, buffer=bufnr})

    -- Actions
    vim.keymap.set('n', '<leader>hs', gs.stage_hunk, {buffer=bufnr})
    vim.keymap.set('n', '<leader>hr', gs.reset_hunk, {buffer=bufnr})
    vim.keymap.set('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {buffer=bufnr})
    vim.keymap.set('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {buffer=bufnr})
    vim.keymap.set('n', '<leader>hS', gs.stage_buffer, {buffer=bufnr})
    vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, {buffer=bufnr})
    vim.keymap.set('n', '<leader>hR', gs.reset_buffer, {buffer=bufnr})
    vim.keymap.set('n', '<leader>hp', gs.preview_hunk, {buffer=bufnr})
    vim.keymap.set('n', '<leader>hb', function() gs.blame_line{full=true} end, {buffer=bufnr})
    vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame, {buffer=bufnr})
    vim.keymap.set('n', '<leader>hd', gs.diffthis, {buffer=bufnr})
    vim.keymap.set('n', '<leader>hD', function() gs.diffthis('~') end, {buffer=bufnr})
    vim.keymap.set('n', '<leader>td', gs.toggle_deleted, {buffer=bufnr})
  end,

  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  preview_config = {
    border = 'rounded',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}