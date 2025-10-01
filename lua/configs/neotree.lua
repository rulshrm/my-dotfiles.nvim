local M = {}

local folder_icon_map = {
  routes = "󰳙", pages = "󰈙", views = "󰈙", prisma = "󰠱",
  database = "", migrations = "󰚟", seeds = "󰚟",
  config = "󰒓", public = "󱂬", assets = "󰝰", static = "󱂬",
  dist = "󰝒", build = "󰁱", scripts = "󰆍", bin = "󰆍",
  node_modules = "󰎙", vendor = "󰬴", tests = "󰙨", test = "󰙨",
  spec = "󰙨", storage = "󰉋", logs = "󰌱", images = "󰋩",
  img = "󰋩", media = "󰋩", icons = "󰀻", css = "󰌜",
  styles = "󰌜", sass = "󰌜", scss = "󰌜", lib = "󰌸",
  src = "󰈔", include = "󰉦", docs = "󱉟", php = "",
  app = "", resources = "󰈔", mail = "󰇮", lang = "󰗊",
}

local function folder_hl(name)
  if name == "node_modules" then return "DiagnosticWarn" end
  if name == "dist" or name == "build" then return "DiagnosticHint" end
  if name == "tests" or name == "test" then return "DiagnosticInfo" end
  return "Directory"
end

local function custom_dir_icon(config, node, _state)
  if node.type ~= "directory" then return nil end
  local key = node.name:lower()
  local icon = folder_icon_map[key]
  if not icon then
    if node:is_expanded() then
      icon = node.empty and config.icon.folder_empty_open or config.icon.folder_open
    else
      icon = node.empty and config.icon.folder_empty or config.icon.folder_closed
    end
  end
  return { text = icon .. " ", highlight = folder_hl(key) }
end

M.setup = function()
  require("neo-tree").setup({
    enable_git_status = true,
    enable_diagnostics = true,
    default_component_configs = {
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        folder_empty_open = "",
      },
      name = { use_git_status_colors = true },
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = { ".git" },
      },
    },
    renderers = {
      directory = {
        { "indent" },
        { custom_dir_icon },
        { "current_filter" },
        { "name", zindex = 10 },
        { "clipboard" },
        { "diagnostics" },
        { "git_status" },
      },
      file = {
        { "indent" },
        { "icon" },
        { "name", zindex = 10 },
        { "clipboard" },
        { "bufnr" },
        { "modified" },
        { "diagnostics" },
        { "git_status" },
      },
    },
  })
end

return M
