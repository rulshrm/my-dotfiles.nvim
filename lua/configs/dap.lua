local dap = require "dap"

dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
}

dap.configurations.javascript = {
  {
    type = "node2",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
  },
}

dap.configurations.typescript = dap.configurations.javascript