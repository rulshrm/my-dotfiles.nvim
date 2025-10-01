local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Nonaktifkan provider yang tidak digunakan
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Throttle function
local function throttle(func, timeout)
  local timer = vim.loop.new_timer()
  local running = false
  
  return function(...)
    if not running then
      running = true
      func(...)
      timer:start(timeout, 0, function()
        running = false
      end)
    end
  end
end

-- Throttled format
local format = throttle(function()
  require("conform").format({
    async = false,
    timeout_ms = 2000,
    lsp_fallback = true,
  })
end, 250)

-- Create augroups once
local format_group = augroup("FormatGroup", { clear = true })
local general_group = augroup("GeneralGroup", { clear = true })

-- Format group dengan throttling
autocmd("BufWritePre", {
  group = format_group,
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.lua", "*.php", "*.md", "*.yml", "*.yaml" },
  callback = function()
    local max_size = 150 * 1024  -- 150KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
    if ok and stats and stats.size < max_size then
      pcall(function()
        require("conform").format({ async = false, timeout_ms = 2000, lsp_fallback = true })
      end)
    end
  end
})

-- Optimize file reload
autocmd("FocusGained", {
  group = general_group,
  command = "checktime",
})

-- Reload file secara otomatis jika diubah di luar Neovim
autocmd("FileChangedShellPost", {
  group = general_group,
  pattern = "*",
  callback = function()
    vim.cmd("echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None")
  end,
})

autocmd("FileType", {
  group = general_group,
  pattern = { "markdown", "text", "html", "xml" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
  end,
})

-- HTML specific settings
local html_group = augroup("HTMLGroup", { clear = true })

autocmd("FileType", {
  group = html_group,
  pattern = { "html", "htm" },
  callback = function()
    -- Enable syntax highlighting
    vim.cmd("syntax enable")
    vim.cmd("syntax sync fromstart")
    
    -- Enable treesitter highlighting
    vim.cmd("TSBufEnable highlight")
    
    -- Set indentation
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    
    -- Enable emmet if available
    if vim.fn.exists(":EmmetInstall") > 0 then
      vim.cmd("EmmetInstall")
    end
  end,
})

-- Java specific autocmds
local java_group = vim.api.nvim_create_augroup("JavaGroup", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  group = java_group,
  callback = function()
    -- Set compiler
    vim.bo.makeprg = "javac %"
    
    -- Enable code folding
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
    
    -- Format on save dengan Google style
    vim.b.format_on_save = true
  end,
})

-- Dotfiles and .env files group
local dotfiles_group = augroup("DotfilesGroup", { clear = true })

autocmd("BufRead", {
  group = dotfiles_group,
  pattern = {
    ".env*",
    ".*rc",
    ".clang-format",
    ".eslintrc*",
    ".prettierrc*",
    ".gitignore",
    ".dockerignore",
    "*.conf",
  },
  callback = function()
    -- Set filetype for better syntax highlighting
    vim.bo.filetype = "dotenv"
    
    -- Enable line numbers
    vim.wo.number = true
    
    -- Set commentstring
    vim.bo.commentstring = "# %s"
    
    -- Add warning for sensitive files
    if vim.fn.expand("%:t"):match("%.env.*") then
      vim.notify(
        "⚠️ Warning: Editing sensitive environment file", 
        vim.log.levels.WARN
      )
    end
  end,
})

-- Hide sensitive values in .env files
autocmd("BufRead", {
  group = dotfiles_group,
  pattern = ".env*",
  callback = function()
    -- Highlight sensitive keywords
    vim.cmd([[
      syntax match envComment "#.*$"
      syntax match envKey "\v^\s*\w+\ze\="
      syntax match envValue "\v\=\zs.*$"
      
      highlight link envComment Comment
      highlight link envKey Identifier
      highlight link envValue String
    ]])
  end,
})