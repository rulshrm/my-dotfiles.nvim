local actions = require("telescope.actions")

return {
  defaults = {
    prompt_prefix = " 󰭎 ",
    selection_caret = "  ",
    path_display = { "smart" },
    file_ignore_patterns = {
      "node_modules",
      ".git",
      "target",
      "vendor",
      "dist",
      "build",
    },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-x>"] = actions.delete_buffer,
        ["<Esc>"] = actions.close,
      },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
    },
    pickers = {
      find_files = {
        hidden = true,
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
      },
      live_grep = {
        --@usage don't include the filename in the search results
        only_sort_text = true,
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  },
}