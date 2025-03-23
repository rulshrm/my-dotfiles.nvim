# My Neovim Dotfiles

Welcome to my Neovim configuration! This repository contains my custom Neovim setup tailored for web development, including support for **React**, **TypeScript**, **JavaScript**, and more. It is built using [NvChad](https://github.com/NvChad/NvChad) as the base configuration and extended with additional plugins and customizations.

## Features

- **LSP Support**: Configured with `nvim-lspconfig` and `mason.nvim` for managing LSP servers.
- **Formatting and Linting**: Integrated with `conform.nvim` and `null-ls.nvim` for tools like `prettier`, `eslint_d`, `ruff`, and more.
- **Treesitter**: Syntax highlighting, incremental selection, and text objects powered by `nvim-treesitter`.
- **Autocompletion**: Configured with `nvim-cmp` and `LuaSnip` for a smooth coding experience.
- **Debugging**: Debugging support using `nvim-dap` for Node.js and TypeScript.
- **Tabline**: Beautiful tabline using `barbar.nvim`.
- **Git Integration**: Git features powered by `gitsigns.nvim`.
- **Rich UI**: Enhanced visuals with `indent-blankline.nvim`, `hlchunk.nvim`, and `nvim-colorizer.lua`.
- **Discord Rich Presence**: Integrated with `neocord` for Discord status updates.
- **Copilot Integration**: GitHub Copilot support for AI-powered code suggestions.

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/rulshrm/my-dotfiles.nvim.git ~/.config/nvim
   ```
2. Install [Neovim](https://neovim.io/) (v0.8 or later).

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
- Managed by `mason.nvim` and `nvim-lspconfig`.
- Preconfigured LSP servers for:
  - TypeScript/JavaScript (`typescript-language-server`)
  - HTML/CSS (`html-lsp`, `css-lsp`)
  - Lua (`lua-language-server`)
  - Python (`ruff`)
  - Rust (`rust-analyzer`)
  - Go (`gopls`)

### Formatting and Linting
- **`conform.nvim`**: Handles formatting on save.
- **`null-ls.nvim`**: Provides additional formatters and linters.
- Tools used:
  - `prettier`/`prettierd` for web development.
  - `eslint_d` for JavaScript/TypeScript linting.
  - `ruff` for Python linting.
  - `stylua` for Lua formatting.

### Debugging
- Debugging support with `nvim-dap`:
  - Configured for Node.js and TypeScript.

### Treesitter
- Syntax highlighting, folding, and text objects powered by `nvim-treesitter`.
- Parsers installed for:
  - JavaScript, TypeScript, HTML, CSS, JSON, YAML, Markdown, and more.

### Tabline
- Beautiful tabline with `barbar.nvim`:
  - Supports buffer navigation and management.

### Git Integration
- Git features powered by `gitsigns.nvim`:
  - Stage/unstage hunks, preview changes, and more.

### Rich UI
- **`indent-blankline.nvim`**: Displays indentation guides.
- **`hlchunk.nvim`**: Highlights code chunks for better readability.
- **`nvim-colorizer.lua`**: Highlights color codes in files.

### Discord Rich Presence
- Integrated with `neocord` for Discord status updates.

### Copilot Integration
- GitHub Copilot support for AI-powered code suggestions.
- Keybindings for accepting, navigating, and dismissing suggestions.

## Key Mappings

Here are some of the key mappings configured in this setup:

### General
- `;`: Enter command mode.
- `jk`: Exit insert mode.

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

### Window Management
- `<leader>ws`: Split horizontally.
- `<leader>wv`: Split vertically.
- `<leader>wh`: Move to the left window.
- `<leader>wj`: Move to the bottom window.
- `<leader>wk`: Move to the top window.
- `<leader>wl`: Move to the right window.
- `<leader>wq`: Close the current window.

### Git
- `<leader>gs`: Stage hunk.
- `<leader>gu`: Undo stage hunk.
- `<leader>gp`: Preview hunk.
- `<leader>gb`: Blame line.
- `<leader>gr`: Reset hunk.
- `<leader>gR`: Reset buffer.

### Debugging
- `<F5>`: Start debugging.
- `<F10>`: Step over.
- `<F11>`: Step into.
- `<F12>`: Step out.

### Copilot
- `<C-e>`: Accept Copilot suggestion.
- `<C-n>`: Go to the next Copilot suggestion.
- `<C-p>`: Go to the previous Copilot suggestion.
- `<C-d>`: Dismiss Copilot suggestion.

## File Structure

```
~/.config/nvim/
├── chadrc.lua
├── mappings.lua
├── options.lua
├── configs/
│   ├── barbar.lua
│   ├── chunk.lua
│   ├── cmp.lua
│   ├── conform.lua
│   ├── dap.lua
│   ├── discord.lua
│   ├── folding.lua
│   ├── inline-diagnostics.lua
│   ├── lazy.lua
│   ├── lspconfig.lua
│   ├── mason-conform.lua
│   ├── minty.lua
│   ├── null-ls.lua
│   ├── treesitter.lua
├── plugins/
│   └── init.lua
├── init.lua
└── .stylua.toml
```

## Contributing

Feel free to fork this repository and submit pull requests if you have improvements or suggestions!

## License

This configuration is open-source and available under the [MIT License](LICENSE).