# Sethy's Neovim Configuration

A modern, feature-rich Neovim configuration focused on web development, with excellent TypeScript, JavaScript, Java, and Lua support.

![Neovim Version](https://img.shields.io/badge/Neovim-0.11.5-green.svg)
![Lua](https://img.shields.io/badge/Lua-5.1-blue.svg)

---

## Features

### Core Capabilities
- **Modern LSP Integration** - Full language server protocol support with automatic installation
- **Intelligent Autocompletion** - Context-aware completions with snippets
- **Advanced Git Workflow** - Comprehensive git operations with visual diff tools
- **Fuzzy Finding** - Lightning-fast file and text search with Telescope
- **Terminal Integration** - Floating terminal with tmux support
- **Session Management** - Automatic workspace persistence
- **Multi-Cursor Editing** - VSCode-like multi-cursor support
- **Code Formatting** - Automatic formatting with Prettier and LSP
- **Debugging Support** - DAP integration for multiple languages

### UI/UX Enhancements
- **Beautiful Statusline** - Customized lualine with git integration
- **File Explorer** - Feature-rich nvim-tree with icons
- **Bufferline** - VSCode-like buffer/tab management
- **Which-key Integration** - Discover keybindings as you type
- **Smooth Scrolling** - Enhanced navigation experience
- **Code Folding** - Smart folding with nvim-ufo
- **Dashboard** - Beautiful startup screen
- **Noice UI** - Modern command line and notification UI

---

## Supported Languages

### Primary Support (with full LSP, formatting, linting)
- **JavaScript/TypeScript** - ts_ls, Deno, TypeScript-tools
- **Java** - JDTLS with full Java development support
- **Lua** - lua_ls with Neovim API support
- **Python** - pyright
- **Go** - gopls
- **Rust** - rust-analyzer

### Additional Support
- HTML/CSS/SCSS - with Emmet support
- Tailwind CSS - with tailwind-tools
- Markdown - with render-markdown
- JSON/YAML
- Bash/Shell scripts

---

## Plugin Ecosystem

### Core Plugins

**Plugin Manager**
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Modern plugin manager

**LSP & Completion**
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configuration
- [mason.nvim](https://github.com/williamboman/mason.nvim) - LSP/DAP/Linter installer
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Autocompletion engine
- [typescript-tools.nvim](https://github.com/pmizio/typescript-tools.nvim) - Enhanced TypeScript support
- [nvim-java](https://github.com/nvim-java/nvim-java) - Full Java development support

**Syntax & Treesitter**
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Advanced syntax highlighting

**File Navigation**
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) - File explorer
- [harpoon](https://github.com/ThePrimeagen/harpoon) - Quick file navigation

**Git Integration**
- [vim-fugitive](https://github.com/tpope/vim-fugitive) - Git commands
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git decorations
- [diffview.nvim](https://github.com/sindrets/diffview.nvim) - Visual diff tool
- [git-conflict.nvim](https://github.com/akinsho/git-conflict.nvim) - Conflict resolution
- [git-worktree.nvim](https://github.com/ThePrimeagen/git-worktree.nvim) - Worktree management

**Code Editing**
- [nvim-surround](https://github.com/kylechui/nvim-surround) - Surround text objects
- [vim-visual-multi](https://github.com/mg979/vim-visual-multi) - Multi-cursor editing
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Auto close brackets
- [Comment.nvim](https://github.com/numToStr/Comment.nvim) - Smart commenting
- [mini.nvim](https://github.com/echasnovski/mini.nvim) - Collection of useful utilities

**Formatting & Linting**
- [conform.nvim](https://github.com/stevearc/conform.nvim) - Code formatting
- [nvim-lint](https://github.com/mfussenegger/nvim-lint) - Asynchronous linting

**UI Enhancements**
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Statusline
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - Buffer/tab line
- [noice.nvim](https://github.com/folke/noice.nvim) - Modern UI for messages
- [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim) - Startup screen
- [incline.nvim](https://github.com/b0o/incline.nvim) - Floating statusline

**Utilities**
- [undotree](https://github.com/mbbill/undotree) - Undo history visualizer
- [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) - Better code folding
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - Highlight TODO comments
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) - Tmux integration
- [auto-session](https://github.com/rmagatti/auto-session) - Session management
- [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) - Markdown preview

**AI & Advanced**
- [avante.nvim](https://github.com/yetone/avante.nvim) - AI-powered coding assistant
- [lazydev.nvim](https://github.com/folke/lazydev.nvim) - Neovim Lua development

**Debugging**
- [nvim-dap](https://github.com/mfussenegger/nvim-dap) - Debug Adapter Protocol

---

## Quick Start

### Prerequisites

- Neovim >= 0.11.0
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (recommended: Monaspace Radon)
- Node.js >= 18 (for LSP servers)
- Ripgrep (for Telescope live grep)
- fd (for Telescope file finder)

### Installation

1. **Backup your existing config:**
```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

2. **Clone this repository:**
```bash
git clone <your-repo-url> ~/.config/nvim
```

3. **Start Neovim:**
```bash
nvim
```

Lazy.nvim will automatically install all plugins on first launch.

4. **Install LSP servers:**
```vim
:MasonInstallAll
```

Or install specific servers:
```vim
:Mason
```

### Essential First Steps

1. **Learn the Leader Key** - Press `Space` (your leader key)
2. **Install Language Servers** - Run `:Mason` and install your needed LSP servers
3. **Read the Keymaps** - Open [KEYMAPS.md](./KEYMAPS.md) or press `<leader>?`
4. **Check Health** - Run `:checkhealth` to verify everything is working

---

## Keybindings

**Leader Key:** `Space`

### Most Used Shortcuts

| Keys | Description |
|------|-------------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search in files) |
| `<leader>ee` | Toggle file explorer |
| `<Ctrl+b>` | Toggle floating terminal |
| `<leader>gg` | Open git status |
| `gd` | Go to definition |
| `gr` | Show references |
| `K` | Show documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |

For the complete keybinding reference, see **[KEYMAPS.md](./KEYMAPS.md)**

---

## Configuration Structure

```
~/.config/nvim/
├── init.lua                      # Entry point
├── lazy-lock.json                # Plugin version lock
├── lua/
│   ├── current-theme.lua         # Theme configuration
│   └── sethy/
│       ├── core/
│       │   ├── init.lua          # Core module loader
│       │   ├── keymaps.lua       # Global keybindings
│       │   └── options.lua       # Neovim options
│       ├── lazy.lua              # Lazy.nvim setup
│       ├── terminalpop.lua       # Terminal configuration
│       ├── neovide.lua           # Neovide GUI settings
│       └── plugins/
│           ├── init.lua          # Plugin dependencies
│           ├── lsp/
│           │   ├── lspconfig.lua # LSP configurations
│           │   └── mason.lua     # Mason setup
│           ├── *.lua             # Individual plugin configs
│           └── ...
├── after/
│   └── ftplugin/
│       └── markdown.lua          # Markdown-specific settings
├── KEYMAPS.md                    # Complete keybinding reference
└── README.md                     # This file
```

---

## Customization

### Changing the Theme

Edit `lua/current-theme.lua`:
```lua
return {
    theme = "tokyonight",  -- Change to your preferred theme
}
```

Available themes are configured in `lua/sethy/plugins/colorscheme.lua`

### Adding Custom Keymaps

Add your keymaps to `lua/sethy/core/keymaps.lua`:
```lua
vim.keymap.set("n", "<leader>custom", ":YourCommand<CR>", { desc = "Your description" })
```

### Installing Additional LSP Servers

1. Open Mason: `:Mason`
2. Search for your language server
3. Press `i` to install

Or add to your Mason configuration in `lua/sethy/plugins/lsp/mason.lua`

### Adding New Plugins

Create a new file in `lua/sethy/plugins/`:
```lua
return {
    "author/plugin-name",
    config = function()
        -- Plugin configuration
    end
}
```

Lazy.nvim will automatically load it on next restart.

---

## Workflows

### Web Development Workflow

1. **Start Project**: `nvim`
2. **Find Files**: `<leader>ff`
3. **Search Code**: `<leader>fg`
4. **Navigate**: Use `gd`, `gr`, `gI` for LSP navigation
5. **Format**: `<leader>mp` for Prettier formatting
6. **Git**:
   - `<leader>gg` for git status
   - `<leader>gs` to stage hunks
   - `<leader>gp` to preview changes
7. **Terminal**: `<Ctrl+b>` for quick terminal access

### Java Development Workflow

1. **Open Project**: `nvim` (auto-detects Java projects)
2. **Build**: Gradle/Maven integration via LSP
3. **Navigate**: `gd` for definitions, `gI` for implementations
4. **Refactor**:
   - `<leader>cm` to implement interface methods
   - `<leader>cg` to generate getters/setters
   - `<leader>cc` to generate constructors
5. **Debug**: Use DAP integration for debugging

### Markdown Workflow

1. **Preview**: Automatic markdown rendering
2. **Todo Lists**:
   - `tc` to toggle checkboxes
   - `tt` to toggle task states
3. **Format**: Auto-formatting on save
4. **Navigate**: `]h` / `[h` for headings (via Treesitter)

---

## Troubleshooting

### LSP Not Working

```vim
:LspInfo          " Check LSP status
:Mason            " Verify language servers are installed
:checkhealth lsp  " Run health checks
```

### Plugins Not Loading

```vim
:Lazy sync        " Sync plugins
:Lazy clean       " Remove unused plugins
:Lazy restore     " Restore from lazy-lock.json
```

### Performance Issues

```vim
:checkhealth      " Check overall health
:Lazy profile     " Check plugin load times
```

### Common Issues

**Issue**: Telescope live grep not working
**Solution**: Install ripgrep: `brew install ripgrep` (macOS) or `apt install ripgrep` (Linux)

**Issue**: Icons not showing
**Solution**: Install a Nerd Font and set it in your terminal

**Issue**: Copilot/AI features not working
**Solution**: Check Avante.nvim configuration and API keys

---

## System Requirements

### Required

- Neovim >= 0.11.0
- Git >= 2.19.0
- A terminal with true color support

### Recommended

- **macOS**: iTerm2 or Kitty
- **Linux**: Alacritty, Kitty, or WezTerm
- **Windows**: Windows Terminal with WSL2

### External Tools

```bash
# macOS
brew install ripgrep fd node

# Ubuntu/Debian
apt install ripgrep fd-find nodejs npm

# Arch Linux
pacman -S ripgrep fd nodejs npm
```

---

## Key Features Detail

### LSP Features
- Auto-completion with snippets
- Go to definition/declaration/implementation
- Find references
- Hover documentation
- Signature help
- Code actions
- Rename refactoring
- Diagnostics and error checking
- Auto-import

### Git Features
- Stage/unstage hunks
- Preview changes
- Blame annotations
- Visual diff viewer
- Conflict resolution
- Worktree management
- Commit browsing
- File history

### Editing Features
- Multi-cursor editing (VSCode-like)
- Surround text objects
- Auto-pairs
- Smart commenting
- Smart indentation
- Code folding
- Undo tree visualization
- Persistent undo

---

## Credits

This configuration is built on the shoulders of giants:

- [Neovim](https://neovim.io/) - The editor
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin management
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configurations
- And all the amazing plugin authors!

Special thanks to the Neovim community for creating such an amazing ecosystem.

---

## License

MIT License - Feel free to use and modify for your own needs!

---

## Documentation

- **[KEYMAPS.md](./KEYMAPS.md)** - Complete keybinding reference
- `:help <plugin-name>` - Plugin-specific help
- `:checkhealth` - System health diagnostics

---

*Last updated: November 2025*
*Neovim version: 0.11.5*
