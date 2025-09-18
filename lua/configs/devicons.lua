local M = {}

M.setup = function()
  local ok, material = pcall(require, "nvim-material-icon")
  local override = ok and material.get_icons() or {}
  require("nvim-web-devicons").setup({
    override = override,
    default = true,
  })
end

return M