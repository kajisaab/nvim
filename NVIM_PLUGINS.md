# Neovim Plugins & Configuration Guide

## Overview
This Neovim configuration provides a modern, full-featured development environment optimized for multiple programming languages with excellent LSP integration, git workflows, and productivity tools.

## Plugin Categories

### 📁 File Management
#### NvimTree
- **Purpose**: Traditional file explorer sidebar
- **Features**: Tree view, file operations, git integration
- **Key Files**: `lua/sethy/plugins/nvim-tree.lua`

#### Oil.nvim
- **Purpose**: Directory browser that edits directories like files
- **Features**: Edit directories directly, file operations in buffer
- **Key Files**: `lua/sethy/plugins/oil.lua`

#### Telescope
- **Purpose**: Fuzzy finder for files, text, and more
- **Features**: File search, live grep, recent files, help tags
- **Key Files**: `lua/sethy/plugins/telescope.lua`

### 🔧 Language Server Protocol (LSP)
#### nvim-lspconfig
- **Purpose**: LSP client configuration
- **Features**: Auto-completion, diagnostics, go-to-definition
- **Languages**: Lua, TypeScript/JavaScript, Deno, Emmet, Java
- **Key Files**: `lua/sethy/plugins/lsp/lspconfig.lua`

#### Mason
- **Purpose**: LSP server installer and manager
- **Features**: Automatic installation of language servers, formatters, linters
- **Key Files**: `lua/sethy/plugins/lsp/mason.lua`

### 💬 Autocompletion
#### nvim-cmp
- **Purpose**: Completion engine
- **Sources**: LSP, buffer, path, snippets, emojis
- **Features**: Intelligent completion with multiple sources
- **Key Files**: `lua/sethy/plugins/nvim-cmp.lua`

#### LuaSnip
- **Purpose**: Snippet engine
- **Features**: Powerful snippet expansion and navigation
- **Integration**: Works with nvim-cmp for snippet completion

### 🎨 Syntax & UI
#### nvim-treesitter
- **Purpose**: Advanced syntax highlighting and parsing
- **Features**: Better syntax highlighting, code folding, text objects
- **Languages**: 25+ languages supported
- **Key Files**: `lua/sethy/plugins/treesitter.lua`

#### TokyoNight Theme
- **Purpose**: Modern color scheme
- **Features**: Multiple variants, terminal support
- **Key Files**: `lua/sethy/plugins/colorscheme.lua`, `lua/current-theme.lua`

#### Lualine
- **Purpose**: Status line
- **Features**: Git info, LSP status, file info, diagnostics
- **Key Files**: `lua/sethy/plugins/lualine.lua`

### 🔍 Navigation & Search
#### Harpoon
- **Purpose**: Quick file navigation
- **Features**: Mark frequently used files, quick switching
- **Key Files**: `lua/sethy/plugins/harpoon.lua`

#### Which-key
- **Purpose**: Keybinding helper
- **Features**: Shows available keybindings, documentation
- **Key Files**: `lua/sethy/plugins/init.lua`

### 📝 Git Integration
#### Gitsigns
- **Purpose**: Git integration in buffers
- **Features**: Show changes, stage hunks, blame info
- **Key Files**: `lua/sethy/plugins/gitstuff.lua`

#### Git Worktree
- **Purpose**: Git worktree management
- **Features**: Switch between worktrees, create new ones
- **Key Files**: `lua/sethy/plugins/gitworktree.lua`

### 🐛 Debugging & Diagnostics
#### Trouble
- **Purpose**: Diagnostics and quickfix list manager
- **Features**: Pretty diagnostics, workspace errors
- **Key Files**: `lua/sethy/plugins/trouble.lua`

#### nvim-dap
- **Purpose**: Debug Adapter Protocol client
- **Features**: Debugging support for multiple languages
- **Key Files**: `lua/sethy/plugins/debugging.lua`

### ✨ Code Enhancement
#### vim-surround
- **Purpose**: Text object manipulation
- **Features**: Quick operations on quotes, brackets, tags
- **Key Files**: `lua/sethy/plugins/surround.lua`

#### auto-pairs
- **Purpose**: Automatic bracket completion
- **Features**: Smart bracket/quote insertion and deletion
- **Key Files**: `lua/sethy/plugins/auto-pairs.lua`

#### Comment.nvim
- **Purpose**: Smart commenting
- **Features**: Language-aware commenting, visual mode support

### 🧹 Code Quality
#### conform.nvim
- **Purpose**: Code formatting
- **Features**: Multiple formatter support, auto-format on save
- **Key Files**: `lua/sethy/plugins/formatting.lua`

#### nvim-lint
- **Purpose**: Linting integration
- **Features**: Multiple linter support, async linting
- **Key Files**: `lua/sethy/plugins/linting.lua`

### 📚 Language-Specific
#### nvim-jdtls
- **Purpose**: Enhanced Java support
- **Features**: Eclipse JDT Language Server integration
- **Key Files**: `lua/sethy/plugins/java.lua`

#### emmet-vim
- **Purpose**: HTML/CSS expansion
- **Features**: Emmet abbreviations, web development workflow
- **Key Files**: `lua/sethy/plugins/emmet.lua`

### 🖼️ Media & Markdown
#### render-markdown.nvim
- **Purpose**: Enhanced markdown rendering
- **Features**: Live preview, syntax highlighting
- **Key Files**: `lua/sethy/plugins/render-markdown.lua`

#### image.nvim
- **Purpose**: Image support in terminal
- **Features**: View images directly in Neovim
- **Key Files**: `lua/sethy/plugins/image-support.lua`

### 💻 Terminal Integration
#### Terminal Popup
- **Purpose**: Floating terminal windows
- **Features**: Quick terminal access, multiple orientations
- **Key Files**: `lua/sethy/terminalpop.lua`

### 🔄 Session Management
#### auto-session
- **Purpose**: Automatic session management
- **Features**: Save/restore sessions, project-specific sessions
- **Key Files**: `lua/sethy/plugins/auto-session.lua`

### 🎯 Productivity Tools
#### undotree
- **Purpose**: Undo history visualization
- **Features**: Visual undo tree, navigate changes
- **Key Files**: `lua/sethy/plugins/undotree.lua`

#### vim-maximizer
- **Purpose**: Window maximization
- **Features**: Toggle window maximize/restore
- **Key Files**: `lua/sethy/plugins/vim-maximizer.lua`

#### todo-comments.nvim
- **Purpose**: TODO comment highlighting
- **Features**: Highlight and search TODO comments
- **Key Files**: `lua/sethy/plugins/todo-comments.lua`

## Configuration Structure

### Core Files
- `init.lua` - Main configuration entry point
- `lua/sethy/core/init.lua` - Core settings loader
- `lua/sethy/core/options.lua` - Vim options and settings
- `lua/sethy/core/keymaps.lua` - Global keybindings
- `lua/sethy/lazy.lua` - Plugin manager configuration

### Plugin Organization
- `lua/sethy/plugins/` - Individual plugin configurations
- `lua/sethy/plugins/lsp/` - LSP-related configurations
- `lua/current-theme.lua` - Theme selection

### Language Support
This configuration provides excellent support for:
- **JavaScript/TypeScript** - Full LSP, formatting, linting
- **Lua** - Neovim-optimized development
- **Java** - Enhanced with JDTLS
- **Python** - LSP and debugging support
- **Go** - Full language support
- **HTML/CSS** - Emmet integration
- **Markdown** - Enhanced rendering
- **JSON/YAML** - Syntax and validation

### Key Features

#### 🚀 Performance
- Lazy loading of plugins
- Treesitter for fast syntax highlighting
- Optimized startup time

#### 🔧 Development Workflow
- Integrated LSP for multiple languages
- Auto-formatting and linting
- Git integration throughout
- Debugging support
- Session management

#### 🎨 User Experience
- Modern UI with consistent theme
- Helpful keybinding discovery
- Quick navigation tools
- Terminal integration
- Image and markdown support

#### 📱 Extensibility
- Modular plugin architecture
- Easy to add new languages
- Configurable keybindings
- Plugin-specific settings

## Getting Started

1. **Basic Navigation**: Use `<leader>` (space) + `ff` to find files
2. **Code Editing**: LSP provides auto-completion, diagnostics, and navigation
3. **Git Workflow**: Use gitsigns for staging hunks and viewing changes
4. **Terminal**: Press `<A-i>` for floating terminal
5. **Help**: Use which-key (`<leader>` then wait) to discover keybindings

## Customization

- Modify `lua/sethy/core/keymaps.lua` for custom keybindings
- Add new plugins in `lua/sethy/plugins/`
- Adjust theme in `lua/current-theme.lua`
- Configure LSP servers in `lua/sethy/plugins/lsp/`

---

*This configuration is designed for productive development with modern tooling and excellent language support.*