- ~/.config/nvim/lua/configs/dap.lua
local dap = require "dap"

-- ╔══════════════════════════════════════════════════════════════╗
-- ║  codelldb — C / C++ / Rust  (installed via mason-nvim-dap)  ║
-- ╚══════════════════════════════════════════════════════════════╝
local codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" },
  },
}

-- Shared launch configuration for C/C++
local cpp_config = {
  {
    name = "Launch executable",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = function()
      local input = vim.fn.input("Arguments: ")
      return vim.split(input, " ", { trimempty = true })
    end,
  },
  {
    name = "Launch current file (single-file build)",
    type = "codelldb",
    request = "launch",
    program = function()
      -- Compile current file with debug symbols, then run
      local src = vim.fn.expand("%:p")
      local out = vim.fn.expand("%:p:r")
      vim.fn.system(string.format("g++ -g -std=c++20 -o %s %s", vim.fn.shellescape(out), vim.fn.shellescape(src)))
      return out
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
  {
    name = "Attach to process",
    type = "codelldb",
    request = "attach",
    pid = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
}

dap.configurations.cpp = cpp_config
dap.configurations.c = cpp_config
dap.configurations.rust = cpp_config

-- ╔════════════════════════════╗
-- ║  Node.js (node-debug2)    ║
-- ╚════════════════════════════╝
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

-- ╔════════════════════════╗
-- ║  PHP (Xdebug)         ║
-- ╚════════════════════════╝
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { vim.fn.stdpath("data") .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js" }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003,
    pathMappings = {
      ["/var/www/html"] = "${workspaceFolder}"
    }
  }
}

-- ╔════════════════════════╗
-- ║  Java                 ║
-- ╚════════════════════════╝
dap.adapters.java = {
  type = 'executable',
  command = 'java',
  args = {'-jar', vim.fn.stdpath("data") .. '/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar'},
}

dap.configurations.java = {
  {
    type = 'java',
    request = 'launch',
    name = "Launch Java Program",
    mainClass = "${file}",
    projectName = "${workspaceFolder}",
  },
}

-- ╔══════════════════════════════════════╗
-- ║  DAP UI — signs for breakpoints     ║
-- ╚══════════════════════════════════════╝
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "◈", texthl = "DapLogPoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })