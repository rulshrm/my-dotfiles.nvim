-- ~/.config/nvim/lua/plugins/cpp/init.lua
-- C++ development plugins: DAP UI, mason-nvim-dap, cmake-tools

return {
  -- ╔══════════════════════════════════════════════╗
  -- ║  nvim-dap-ui — visual debugger interface     ║
  -- ╚══════════════════════════════════════════════╝
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    event = "VeryLazy",
    config = function()
      local dapui = require("dapui")
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "→" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.35 },
              { id = "breakpoints", size = 0.15 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 0.25,
            position = "bottom",
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = "rounded",
          mappings = { close = { "q", "<Esc>" } },
        },
        render = {
          max_type_length = nil,
          max_value_lines = 100,
        },
      })

      -- Auto open/close DAP UI when debugging starts/stops
      local dap = require("dap")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- ╔══════════════════════════════════════════════════════╗
  -- ║  nvim-dap-virtual-text — inline variable display    ║
  -- ╚══════════════════════════════════════════════════════╝
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    opts = {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      clear_on_continue = false,
      virt_text_pos = "eol",
    },
  },

  -- ╔══════════════════════════════════════════════════════════╗
  -- ║  mason-nvim-dap — auto-install DAP adapters via Mason   ║
  -- ╚══════════════════════════════════════════════════════════╝
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    event = "VeryLazy",
    opts = {
      ensure_installed = { "codelldb" },
      automatic_installation = true,
      handlers = {},
    },
  },

  -- ╔══════════════════════════════════════════════════════════╗
  -- ║  cmake-tools.nvim — CMake configure/build/run/debug     ║
  -- ╚══════════════════════════════════════════════════════════╝
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "c", "cpp", "cmake" },
    opts = {
      cmake_command = "cmake",
      ctest_command = "ctest",
      cmake_build_directory = "build",
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      cmake_build_options = {},
      cmake_console_size = 15,
      cmake_show_console = "always",
      cmake_dap_configuration = {
        name = "cpp",
        type = "codelldb",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = true,
        console = "integratedTerminal",
      },
      cmake_dap_open_command = function()
        require("dapui").open()
      end,
      cmake_variants_message = {
        short = { show = true },
        long = { show = true, max_length = 40 },
      },
    },
  },
}
