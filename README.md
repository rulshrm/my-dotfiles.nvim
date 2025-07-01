# My Neovim Dotfiles

Welcome to my Neovim configuration! This repository contains my custom Neovim setup tailored for web development and other programming languages, including support for **React**, **TypeScript**, **JavaScript**, **Java**, **PHP/Laravel**, and more. It is built using [NvChad](https://github.com/NvChad/NvChad) as the base configuration and extended with additional plugins and customizations.

## Key Features

- **LSP Support** with `nvim-lspconfig` and `mason.nvim`
- **Formatting/Linting** with `null-ls.nvim`
- **Autocompletion** with `nvim-cmp` and `copilot.vim`
- **Git Integration** with `gitsigns.nvim`
- **Debugging** with `nvim-dap`

## Quick Install

```bash
git clone https://github.com/rulshrm/my-dotfiles.nvim.git ~/.config/nvim
```

Install dependencies:
- Neovim (v0.8+)
- Node.js
- Python
- Go
- Rust

Then run in Neovim:
```bash
:Lazy sync
```

## Essential Keymaps

### General
- `;`: Enter command mode
- `jk`: Exit insert mode (in insert mode)
- `<leader>ih`: Toggle inlay hints
- `<leader>tw`: Toggle word wrap

### LSP
- `gd`: Go to Definition
- `gr`: Go to References
- `K`: Show hover documentation
- `<leader>rn`: Rename symbol
- `<leader>ca`: Code actions
- `[d`: Previous diagnostic
- `]d`: Next diagnostic
- `<leader>d`: Show line diagnostics

### Formatting
- `<leader>f`: Format current file with conform.nvim

### Tab Navigation (using barbar.nvim)
- `<Tab>`: Next tab
- `<S-Tab>`: Previous tab
- `<leader>tc`: Close current tab
- `<leader>ba`: Close all buffers except current
- `<leader>bl`: Close all buffers to the left
- `<leader>br`: Close all buffers to the right
- `<leader>1-9`: Go to specific tab
- `<leader>0`: Go to last tab

### Window Management
- `<leader>ws`: Split horizontally
- `<leader>wv`: Split vertically
- `<leader>wh`: Move to left window
- `<leader>wj`: Move to bottom window
- `<leader>wk`: Move to top window
- `<leader>wl`: Move to right window
- `<leader>wq`: Close current window

### Telescope
- `<leader>ff`: Find files
- `<leader>fg`: Live grep (search in files)
- `<leader>fb`: Find buffers
- `<leader>fh`: Find help tags

### Git Integration
#### Gitsigns
- `<leader>gs`: Stage hunk
- `<leader>gu`: Undo stage hunk
- `<leader>gp`: Preview hunk
- `<leader>gb`: Blame line
- `<leader>gr`: Reset hunk
- `<leader>gR`: Reset buffer

#### Git Graph (Fugit2)
- `<leader>gg`: Open Git Graph
- `<leader>gf`: Show File History
- `<leader>gdf`: Show Git Diff

#### Git Conflict
- `<leader>gco`: Choose Ours
- `<leader>gct`: Choose Theirs
- `<leader>gcb`: Choose Both
- `<leader>gcn`: Next Conflict
- `<leader>gcp`: Previous Conflict

### Java Development
- `<leader>jr`: Run Java file
- `<leader>jR`: Run Java file with arguments
- `<leader>jt`: Run Java test class
- `<leader>jn`: Run nearest Java test method
- `<leader>jo`: Organize imports
- `<leader>jb`: Toggle breakpoint
- `<leader>jem`: Extract method (visual mode)
- `<leader>jev`: Extract variable (visual mode)

### Debugging
- `<F5>`: Start/Continue debugging
- `<F10>`: Step over
- `<F11>`: Step into
- `<F12>`: Step out
- `<leader>db`: Toggle breakpoint
- `<leader>dr`: Open debug REPL

### Copilot
- `<Tab>`: Accept suggestion
- `<C-n>`: Next suggestion
- `<C-p>`: Previous suggestion
- `<C-d>`: Dismiss suggestion

### REST Client
- `<leader>rr`: Run HTTP request
- `<leader>rp`: Preview HTTP request
- `<leader>rl`: Run last HTTP request

### Code Refactoring
- `<leader>re`: Extract function (visual mode)
- `<leader>rf`: Extract function to file (visual mode)
- `<leader>rv`: Extract variable (visual mode)
- `<leader>ri`: Inline variable (visual mode)
- `<leader>rb`: Extract block
- `<leader>rbf`: Extract block to file

### Laravel (PHP)
- `<leader>la`: Laravel Artisan
- `<leader>lr`: Laravel Routes
- `<leader>lm`: Laravel Make
- `<leader>lt`: Laravel Tinker
- `<leader>lc`: Composer

### Folding
- `zc`: Close fold under cursor
- `zo`: Open fold under cursor
- `za`: Toggle fold under cursor
- `zM`: Close all folds
- `zR`: Open all folds

<details>

<summary>## File Structure</summary>

```
~/.config/nvim/
├── init.lua                 # Main configuration file
├── lazy-lock.json          # Plugin version lock file
├── LICENSE                 # MIT License file
├── README.md              # Documentation
└── lua/                   # Lua configurations
    ├── configs/           # Plugin configurations
    │   ├── autocmds.lua          # Auto commands
    │   ├── barbar.lua            # Tab line configuration
    │   ├── cmp.lua               # Completion configuration
    │   ├── copilot-chat.lua      # GitHub Copilot chat
    │   ├── discord.lua           # Discord presence
    │   ├── folding.lua           # Code folding settings
    │   ├── gitsigns.lua          # Git integration
    │   ├── java_utils.lua        # Java utilities
    │   ├── lspconfig.lua         # LSP configuration
    │   ├── notify.lua            # Notification system
    │   ├── null-ls.lua           # Formatting/linting
    │   ├── null-ls-patch.lua     # Patches for null-ls
    │   ├── refactoring.lua       # Code refactoring
    │   ├── rest.lua              # HTTP client
    │   ├── telescope.lua         # Fuzzy finder
    │   ├── treesitter.lua        # Syntax highlighting
    │   └── which-key.lua         # Keybinding helper
    ├── mappings.lua       # Key mappings
    ├── options.lua        # Neovim options
    └── plugins/           # Plugin definitions
        ├── completion/    # Completion plugins
        │   └── init.lua
        ├── docs/          # Documentation plugins
        │   └── init.lua
        ├── editor/        # Editor enhancement plugins
        │   └── init.lua
        ├── git/          # Git-related plugins
        │   └── init.lua
        ├── lsp/          # Language Server plugins
        │   └── init.lua
        ├── ui/           # User Interface plugins
        │   └── init.lua
        └── init.lua      # Core plugins
```

### Key Directories

- `lua/configs/`: Contains configuration files for individual plugins
- `lua/plugins/`: Contains plugin declarations and groupings
- `lua/`: Core Neovim configurations
  - `mappings.lua`: All keybindings
  - `options.lua`: Neovim options and settings

### Plugin Organization

- **Core Plugins**: `plugins/init.lua` - Basic and essential plugins
- **Completion Plugins**: `plugins/completion/init.lua` - Autocompletion and snippets
- **Editor Plugins**: `plugins/editor/init.lua` - Editor enhancements
- **Git Plugins**: `plugins/git/init.lua` - Git integration features
- **LSP Plugins**: `plugins/lsp/init.lua` - Language server related plugins
- **UI Plugins**: `plugins/ui/init.lua` - User interface improvements
- **Documentation Plugins**: `plugins/docs/init.lua` - Documentation generation

### Configuration Files

Each plugin configuration in `configs/` follows a modular approach:
- **LSP**: `lspconfig.lua` - Language server configurations
- **Formatting**: `null-ls.lua` - Code formatting and linting
- **Git**: `gitsigns.lua` - Git integration features
- **Completion**: `cmp.lua` - Autocompletion settings
- **Java**: `java_utils.lua` - Java-specific utilities
- **UI**: `notify.lua`, `which-key.lua` - User interface enhancements
- **Editor**: `folding.lua`, `treesitter.lua` - Editor functionality
- **Tools**: `rest.lua`, `refactoring.lua` - Development tools

</details>

## License

This configuration is open-source and available under the [MIT License](LICENSE).