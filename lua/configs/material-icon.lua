local M = {}

M.setup = function()
  local material_icon = require("nvim-material-icon")
  
  -- Setup material icon
  material_icon.setup({
    override = true,
    custom_icons = {
      [".env"] = {
        icon = "󰙪",
        color = "#faf743",
        name = "Dotenv",
      },
      ["dockerfile"] = {
        icon = "",
        color = "#458ee6",
        name = "Dockerfile",
      },
      [".gitignore"] = {
        icon = "",
        color = "#e24329",
        name = "GitIgnore",
      },
    },
  })
end

return M
