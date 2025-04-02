local M = {}

M.setup = function()
  require("CopilotChat").setup({
    debug = false,
    -- Model configuration 
    model = "gpt-4",        -- Langsung string, bukan table
    temperature = 0.1,      -- Pindahkan ke level root
    top_p = 1,             -- Pindahkan ke level root
    max_tokens = 600,      -- Pindahkan ke level root
    
    -- Window configuration
    window = {
      layout = "float",
      relative = "editor",
      border = "rounded",
      width = 0.8,
      height = 0.8,
    },
    -- Keymaps configuration
    mappings = {
      close = "q",
      reset = "<C-l>",
      complete = "<Tab>",
      submit_prompt = "<CR>",
    },
    -- Prompts configuration
    prompts = {
      Explain = {
        prompt = "Explain how the selected code works in detail.",
      },
      Review = {
        prompt = "Review the selected code for potential improvements, bugs, and security issues.",
      },
      Tests = {
        prompt = "Suggest unit tests for the selected code.",
      },
      Refactor = {
        prompt = "Refactor the selected code to improve its clarity and readability.",
      },
      -- Tambahkan prompt kustom
      Documentation = {
        prompt = "Generate documentation for the selected code using JSDoc format.",
      },
      FixBug = {
        prompt = "Analyze the code for potential bugs and provide fixes.",
      },
      Optimize = {
        prompt = "Suggest performance optimizations for this code.",
      },
    },
  })
end

return M