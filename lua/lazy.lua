local module = ...
local root = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(root) then
  error(("lazy.nvim not found at %s; run :Lazy sync or restart after bootstrap."):format(root))
end

local rel = module:gsub("%.", "/")
local candidates = {
  ("%s/lua/%s.lua"):format(root, rel),
  ("%s/lua/%s/init.lua"):format(root, rel),
}

local last_err
for _, path in ipairs(candidates) do
  local chunk, err = loadfile(path)
  if chunk then
    return chunk(module)
  end
  last_err = err
end

error(("Failed to load lazy.nvim module '%s': %s"):format(module, last_err or "not found"))
  checker = { enabled = false },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "spellfile",
        "netrwPlugin",
        "matchparen",
      },
    },
  },
}
