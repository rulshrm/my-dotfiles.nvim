require("refactoring").setup({
  prompt_func_return_type = {
    go = true,
    java = true,
    cpp = true,
    c = true,
  },
  prompt_func_param_type = {
    go = true,
    java = true,
    cpp = true,
    c = true,
  },
  printf_statements = {},
  print_var_statements = {},
  highlight_definitions = {
    enable = true, -- Aktifkan highlight untuk definisi
  },
  highlight_current_scope = {
    enable = true, -- Aktifkan highlight untuk scope saat ini
  },
})