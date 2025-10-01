local M = {}

local function on_attach(bufnr)
  local api = require("nvim-tree.api")
  local function map(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = "NvimTree: " .. desc })
  end

  map("l", api.node.open.edit, "Open")
  map("h", api.node.navigate.parent_close, "Close Dir")
  map("o", api.node.open.preview, "Preview")
  map("K", api.node.show_info_popup, "Info")
  map("R", api.tree.reload, "Reload")
  map("a", api.fs.create, "Create")
  map("d", api.fs.remove, "Delete")
  map("r", api.fs.rename, "Rename")
  map("x", api.fs.cut, "Cut")
  map("c", api.fs.copy.node, "Copy")
  map("p", api.fs.paste, "Paste")
  map("y", api.fs.copy.filename, "Yank Name")
  map("Y", api.fs.copy.relative_path, "Yank Rel Path")
  map("gy", api.fs.copy.absolute_path, "Yank Abs Path")
  map("[c", api.node.navigate.git.prev, "Prev Git")
  map("]c", api.node.navigate.git.next, "Next Git")
  map("q", api.tree.close, "Close")
end

M.setup = function()
  -- Pastikan devicons + material ter-load
  pcall(function()
    local ok_mat, mat = pcall(require, "nvim-material-icons")
    if ok_mat then
      local override = mat.get_icons()
      require("nvim-web-devicons").setup({ override = override, default = true })
    end
  end)

  require("nvim-tree").setup({
    on_attach = on_attach,
    disable_netrw = true,
    hijack_netrw = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    hijack_cursor = true,
    update_focused_file = {
      enable = true,
      update_root = true,
      ignore_list = {},
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      debounce_delay = 80,
      icons = {
        hint = "󰌵",
        info = "",
        warning = "",
        error = "",
      },
    },
    git = {
      enable = true,
      ignore = false,
      show_on_dirs = true,
      timeout = 400,
    },
    filesystem_watchers = {
      enable = true,
      debounce_delay = 100,
    },
    filters = {
      dotfiles = false,
      custom = { "^.git$" },
    },
    view = {
      width = 32,
      side = "left",
      signcolumn = "yes",
      preserve_window_proportions = true,
    },
    renderer = {
      root_folder_label = false,
      highlight_git = true,
      highlight_opened_files = "name",
      indent_markers = { enable = true },
      icons = {
        git_placement = "before",
        show = { file = true, folder = true, folder_arrow = true, git = true },
        glyphs = {
          default = "",
          symlink = "",
            -- Folder glyphs
          folder = {
            arrow_closed = "",
            arrow_open   = "",
            default      = "",
            open         = "",
            empty        = "",
            empty_open   = "",
            symlink      = "",
            symlink_open = "",
          },
          git = {
            unstaged  = "✗",
            staged    = "✓",
            unmerged  = "",
            renamed   = "➜",
            untracked = "★",
            deleted   = "",
            ignored   = "◌",
          },
        },
      },
    },
    actions = {
      open_file = {
        quit_on_open = false,
        resize_window = true,
        window_picker = { enable = false },
      },
      change_dir = { enable = true, global = true },
    },
    trash = {
      cmd = "trash", -- ganti ke "gio trash" atau "rm" sesuai sistem
      require_confirm = true,
    },
    log = {
      enable = false,
      truncate = true,
      types = { diagnostics = false, git = false, profile = false },
    },
  })
end

return M
