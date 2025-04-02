# My Neovim Dotfiles

Welcome to my Neovim configuration! This repository contains my custom Neovim setup tailored for web development, including support for **React**, **TypeScript**, **JavaScript**, and more. It is built using [NvChad](https://github.com/NvChad/NvChad) as the base configuration and extended with additional plugins and customizations.

## Features

- **LSP Support**: Configured with `nvim-lspconfig` and `mason.nvim` for managing LSP servers
- **Formatting and Linting**: Integrated with `null-ls.nvim` for tools like `prettierd`, `eslint_d`, and more
- **Treesitter**: Syntax highlighting, incremental selection, and text objects powered by `nvim-treesitter`
- **Autocompletion**: Configured with `nvim-cmp` and `copilot.vim` for AI-powered suggestions
- **Debugging**: Debugging support using `nvim-dap` for Node.js and TypeScript
- **Tabline**: Beautiful tabline using `barbar.nvim`
- **Git Integration**: Git features powered by `gitsigns.nvim`
- **Rich UI**: Enhanced visuals with `indent-blankline.nvim`, `hlchunk.nvim`, and `nvim-colorizer.lua`
- **Discord Rich Presence**: Integrated with `neocord`
- **Import Cost**: View import costs in JavaScript/TypeScript files with `import-cost.nvim`

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/rulshrm/my-dotfiles.nvim.git ~/.config/nvim
   ```

2. Install [Neovim](https://neovim.io/) (v0.8 or later)

3. Install the required dependencies:
- **Node.js**: Required for LSP servers like `typescript-language-server` and `eslint_d`.
   - **Python**: Required for Python LSP and tools like `ruff`.
   - **Go**: Required for Go LSP (`gopls`).
   - **Rust**: Required for Rust LSP (`rust-analyzer`).

4. Open Neovim and run the following command to install plugins:
   ```bash
      :Lazy sync
      ```

5. Restart Neovim, and you're ready to go!

## Key Features and Plugins

### LSP Configuration
- Managed by `mason.nvim` and `nvim-lspconfig`
- Preconfigured LSP servers:
  - TypeScript/JavaScript (`tsserver`)
  - HTML/CSS (`html`, `cssls`)
  - JSON (`jsonls`)
  - YAML (`yamlls`)
  - Lua (`lua_ls`)

### Formatting and Linting
- **`null-ls.nvim`**: Provides formatting through `prettierd` and linting through `eslint_d`
- Format on save enabled for supported file types
- Manual formatting with `<leader>f`

### Debugging
- Debugging support with `nvim-dap`:
  - Configured for Node.js and TypeScript

### Git Integration
- Git features with `gitsigns.nvim`:
  - Stage/unstage hunks
  - Preview changes
  - Line blame
  - and more

## Key Mappings

### General
- `;`: Enter command mode
- `jk`: Exit insert mode

### Formatting
- `<leader>f`: Format current file with null-ls/prettierd

### Tab Navigation
- `<Tab>`: Next tab.
- `<S-Tab>`: Previous tab.
- `<leader>tc`: Close current tab.
- `<leader>ba`: Close all buffers except the current one.
- `<leader>bl`: Close all buffers to the left.
- `<leader>br`: Close all buffers to the right.
- `<leader>1`–`<leader>9`: Go to specific tab.

### Telescope
- `<leader>ff`: Find files.
- `<leader>fg`: Live grep.
- `<leader>fb`: Find buffers.
- `<leader>fh`: Find help tags.

### W.
lescope
- `<leader>ff`: Find files.
- `<leader>fg`: Live grep.
- `<leader>fb`: Find buffers.
- `<leader>fh`: Find help tags.
ndow Management
- `<leader>ws`: Split horizontally.
- `<leader>wv`: Split vertically.
- `<leader>wh`: Move to the left window.
- `<leader>wj`: Move to the bottom window.
- `<leader>wk`: Move to the top window.
- `<leader>wl`: Move to the right window.
- `<leader>wq`: Close the current window.

### Git
- `<leader>gs`: Stage hunk
- `<leader>gu`: Undo stage hunk
- `<leader>gp`: Preview hunk
- `<leader>gb`: Blame line
- `<leader>gr`: Reset hunk
- `<leader>gR`: Reset buffer

### Debugging
- `<F5>`: Start debugging
- `<F10>`: Step over
- `<F11>`: Step into
- `<F12>`: Step out
- `<leader>db`: Toggle breakpoint
- `<leader>dr`: Open debug REPL

### Copilot
- `<Tab>`: Accept Copilot suggestion
- `<C-n>`: Next suggestion
- `<C-p>`: Previous suggestion
- `<C-d>`: Dismiss suggestion

## File Structure

```
~/.config/nvim/
├── init.lua                 # Main configuration file
├── lazy-lock.json          # Plugin version lock file
├── chadrc.lua             # NvChad configuration
├── mappings.lua           # Key mappings
├── options.lua            # Neovim options
├── configs/               # Plugin configurations
│   ├── autocmds.lua      # Auto commands
│   ├── barbar.lua        # Tab line configuration
│   ├── chunk.lua         # Code chunk highlighting
│   ├── cmp.lua           # Completion configuration
│   ├── dap.lua           # Debug adapter configuration
│   ├── discord.lua       # Discord presence
│   ├── gitsigns.lua      # Git integration
│   ├── inline-diagnostics.lua
│   ├── lspconfig.lua     # LSP configuration
│   ├── mason.lua         # LSP installer configuration
│   ├── null-ls.lua       # Formatting/linting
│   └── treesitter.lua    # Syntax highlighting
└── plugins/
    └── init.lua          # Plugin declarations
```

## License

This configuration is open-source and available under the [MIT License](LICENSE).