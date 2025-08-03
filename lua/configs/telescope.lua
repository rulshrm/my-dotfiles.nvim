local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
  defaults = {
    prompt_prefix = " 󰭎 ",
    selection_caret = "  ",
    path_display = { "smart" },
    file_ignore_patterns = {
      "node_modules",
      ".git/",
      "dist",
      "build",
      "target",
    },
    hidden = true,  -- Show hidden files
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
      "--glob=!.git/*",
      "--glob=!node_modules/*",
    },
  },
  pickers = {
    find_files = {
      hidden = true,  -- Show hidden files in find_files
      find_command = {
        "fd",
        "--type", "f",
        "--hidden",  -- Show hidden files
        "--no-ignore",  -- Don't respect .gitignore
        "--exclude", ".git",
        "--exclude", "node_modules",
      },
    },
    live_grep = {
      additional_args = function()
        return { 
          "--hidden",  -- Include hidden files in live grep
          "--glob=!node_modules/*"
        }
      end,
    },
  },
})

-- Optional: Setup telescope-fzf-native if installed
pcall(function()
  telescope.load_extension('fzf')
end)
