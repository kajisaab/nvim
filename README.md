# Neovim Configuration

## 🚀 Updated to Latest Versions

**Neovim**: v0.11.5 (Latest stable)
**Plugins**: All updated to latest compatible versions
**LSP**: Updated to use new vim.lsp.config API

## 📚 Documentation

This configuration includes comprehensive documentation:

### 🎯 [QUICK_REFERENCE_CARD.md](./QUICK_REFERENCE_CARD.md) - **PRINT THIS**
One-page printable reference with the most essential shortcuts:
- The Big 5 shortcuts to master first
- Core editing and navigation
- Essential workflows
- Perfect for keeping next to your keyboard

### ⚡ [NVIM_ESSENTIAL_SHORTCUTS.md](./NVIM_ESSENTIAL_SHORTCUTS.md) - **START HERE**
The most frequently used shortcuts for daily productivity:
- Undo/Redo operations
- Search and navigation within files
- Function/code navigation (go to definition, references)
- Jump back/forward in navigation history
- Quick file switching with Harpoon
- Essential workflows and pro tips

### 🚀 [NVIM_ADVANCED_NAVIGATION.md](./NVIM_ADVANCED_NAVIGATION.md)
Advanced navigation techniques for power users:
- Pattern search with regex
- Advanced LSP navigation
- Marks and bookmarks
- Jump list and change list navigation
- Text objects for navigation
- Complex codebase exploration workflows

### 📋 [NVIM_KEYBINDINGS.md](./NVIM_KEYBINDINGS.md)
Complete keybinding reference organized by category:
- Core navigation and editing shortcuts
- Window and tab management
- File management (NvimTree, Oil, Telescope)
- LSP features and diagnostics
- Git integration commands
- Plugin-specific keybindings

### 🔧 [NVIM_PLUGINS.md](./NVIM_PLUGINS.md)
Detailed plugin documentation covering:
- 35+ plugins organized by functionality
- Purpose and key features of each plugin
- Configuration file locations
- Language support details
- Development workflow guidance

### 🔀 [NVIM_GIT_FEATURES.md](./NVIM_GIT_FEATURES.md) - **NEW!**
Advanced Git integration with visual interfaces:
- LazyGit complete Git UI
- Git conflict resolution tools
- DiffView for visual diffs
- Auto-formatting with Prettier for JS/TS
- Complete Git workflows and commands

### 🏥 [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
Comprehensive troubleshooting guide:
- Current status and known issues
- Dependency requirements and installation
- Health check commands
- Common problems and solutions
- Installation command reference

## ⚡ Quick Start

1. **Find Files**: `<Space>ff` - Fuzzy find files
2. **Search Text**: `<Space>fs` - Live grep in project
3. **File Explorer**: `<Space>ee` - Toggle file tree
4. **Terminal**: `<Alt-i>` - Floating terminal
5. **Git**: `<Space>hs` - Stage current hunk

## 🛠 Features

- **Modern LSP Integration** - Full language server support
- **Intelligent Completion** - Context-aware autocompletion
- **Advanced Git Workflow** - Integrated git operations
- **Fuzzy Finding** - Fast file and text search
- **Terminal Integration** - Built-in terminal support
- **Session Management** - Automatic session persistence
- **Debugging Support** - DAP integration for multiple languages

## 🌈 Supported Languages

Primary support for:
- JavaScript/TypeScript (ts_ls, Deno)
- Lua (lua_ls)
- Java (JDTLS)
- Python, Go, Rust
- HTML/CSS (Emmet)
- Markdown, JSON, YAML

## 📖 Usage Tips

- **Leader Key**: Spacebar (`<Space>`)
- **Help**: Press `<Space>` and wait to see available commands
- **LSP Navigation**: `gd` (definition), `gR` (references), `K` (hover)
- **Code Actions**: `<Space>vca` for available code actions
- **Quick Navigation**: Use Harpoon (`<Space>a` to add, `<C-e>` to toggle)

## 🔧 Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Main entry point
├── lua/
│   ├── current-theme.lua      # Theme selection
│   └── sethy/
│       ├── core/              # Core settings
│       │   ├── init.lua
│       │   ├── keymaps.lua    # Global keybindings
│       │   └── options.lua    # Vim options
│       ├── lazy.lua           # Plugin manager
│       ├── terminalpop.lua    # Terminal integration
│       └── plugins/           # Plugin configurations
│           ├── lsp/           # LSP configs
│           ├── *.lua         # Individual plugins
│           └── init.lua      # Plugin loader
├── NVIM_KEYBINDINGS.md       # Keybinding reference
├── NVIM_PLUGINS.md           # Plugin documentation
└── README.md                 # This file
```

## 🎯 Development Workflow

1. **Open Project**: `cd project && nvim`
2. **Find Files**: `<Space>ff` or `<Space>fr` for recent
3. **Navigate Code**: LSP provides go-to-definition, references
4. **Edit**: Auto-completion, snippets, and smart editing
5. **Git**: Stage changes with `<Space>hs`, view diff with `<Space>hp`
6. **Debug**: Use DAP for debugging (language-dependent)
7. **Format**: `<Space>f` for LSP formatting
8. **Terminal**: `<Alt-i>` for quick terminal access

## 🚨 Troubleshooting

- **LSP Not Working**: Check `:LspInfo` and ensure language servers are installed via Mason
- **Plugins Issues**: Run `:Lazy sync` to update plugins
- **Performance**: Check `:checkhealth` for any issues
- **Keybindings**: Refer to NVIM_KEYBINDINGS.md or use which-key

## 📄 License

This configuration is provided as-is for personal use and customization.

---

*Last updated: November 2025 with Neovim v0.11.5*