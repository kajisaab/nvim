# Neovim Configuration Guide

A modern, clean, and highly optimized Neovim configuration with LazyVim-inspired statusline and easy customization.

## 📁 Structure

```
nvim/
├── init.lua                         # Entry point
├── lua/
│   ├── sethy/
│   │   ├── config.lua              # ⭐ MAIN SETTINGS FILE (tweak here!)
│   │   ├── core/
│   │   │   ├── init.lua            # Loads core modules
│   │   │   ├── options.lua         # Editor options (uses config.lua)
│   │   │   ├── keymaps.lua         # Key bindings
│   │   │   └── autocmds.lua        # Auto commands & behaviors
│   │   ├── lazy.lua                # Plugin manager
│   │   ├── plugins/                # Plugin configurations
│   │   │   ├── lsp/                # LSP configs
│   │   │   └── [40+ plugin files]
│   │   └── terminalpop.lua         # Terminal utilities
│   └── current-theme.lua           # Active colorscheme
├── after/ftplugin/                 # Filetype-specific settings
└── .luarc.json                     # Lua LSP configuration
```

## ⚙️ Easy Configuration

### Main Settings File: `lua/sethy/config.lua`

This is your **one-stop configuration file** for tweaking common settings. No need to dig through multiple files!

#### Quick Examples:

**Change Font:**
```lua
M.general = {
  font = {
    name = "JetBrains Mono",  -- Change to your preferred font
    size = 12,                 -- Adjust size
  },
}
```

**Enable Relative Line Numbers:**
```lua
M.general = {
  relativenumber = true,  -- Change from false to true
}
```

**Change Tab Size:**
```lua
M.general = {
  tabstop = 2,       -- Change from 4 to 2
  shiftwidth = 2,    -- Should match tabstop
}
```

**Switch Colorscheme:**
```lua
M.colorscheme = {
  name = "gruvbox",  -- Options: tokyonight, rose-pine, gruvbox, kanagawa
}
```

**Enable Format on Save:**
```lua
M.lsp = {
  format_on_save = true,  -- Auto-format when saving files
}
```

**Auto-restore Sessions:**
```lua
M.session = {
  auto_restore = true,  -- Restore last session on startup
}
```

## 🎨 Statusline

The statusline has been updated to a **LazyVim-inspired design** with:

- **Mode indicator** with color-coded icons
- **Git branch** and **diff stats** (additions/modifications/deletions)
- **Diagnostics** (errors, warnings, info, hints)
- **File icon and path**
- **Active LSP clients**
- **Lazy.nvim pending updates**
- **Line:Column and percentage** in file

### Customization

Edit `lua/sethy/plugins/lualine.lua` to customize:

**Hide LSP clients:**
```lua
lualine_x = {
  lazy_updates,
  -- lsp_clients,  -- Comment out this line
},
```

**Change colors:**
```lua
local colors = {
  blue = "#7aa2f7",    -- Modify these hex values
  green = "#9ece6a",
  orange = "#ff9e64",
  -- ... more colors
}
```

**Disable globalstatus (one statusline for all windows):**
```lua
options = {
  globalstatus = false,  -- Change to false for per-window statusline
}
```

## 🔑 Key Bindings

Leader key: **Space**

### Essential Shortcuts

| Key | Action |
|-----|--------|
| `<leader>ee` | Toggle file explorer (NvimTree) |
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep (search in files) |
| `Ctrl+F` | Search in current directory |
| `<leader>s` | Find and replace in file |
| `<leader>sr` | Find and replace with confirmation |
| `Ctrl+S` | Save file |
| `<leader>x` | Close buffer |
| `Shift+H` / `Shift+L` | Navigate buffers |
| `<leader>gg` | Open git interface (Fugitive) |
| `<leader>gp` | Git preview hunk |
| `<leader>gB` | Toggle git blame line |

### Movement Enhancements

| Key | Action |
|-----|--------|
| `Alt+j` / `Alt+k` | Jump 10 lines down/up |
| `Ctrl+j` / `Ctrl+k` | Half-page down/up |
| `Alt+h` / `Alt+l` | Word navigation left/right |
| `J` / `K` (Visual) | Move selected lines up/down |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `K` | Show hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>lx` | Toggle diagnostics |

Full keymap list in `lua/sethy/core/keymaps.lua`

## 🔌 Installed Plugins

### UI & Appearance
- **lualine** - Modern statusline (LazyVim style)
- **bufferline** - Buffer tabs at top
- **incline** - Floating filename display
- **dashboard** - Startup screen
- **noice** - Enhanced UI for messages/cmdline
- **nvim-tree** - File explorer

### LSP & Completion
- **mason** - LSP/formatter/linter installer
- **nvim-lspconfig** - LSP configurations
- **nvim-cmp** - Completion engine
- **LuaSnip** - Snippet engine
- **conform.nvim** - Formatting
- **nvim-lint** - Linting

### Git Integration
- **vim-fugitive** - Git commands
- **gitsigns** - Git signs in gutter
- **diffview** - Advanced diff viewer
- **git-conflict** - Conflict resolution
- **git-messenger** - Show commit history

### Code Tools
- **treesitter** - Better syntax highlighting
- **telescope** - Fuzzy finder
- **trouble** - Diagnostics/quickfix list
- **todo-comments** - Highlight TODO/FIXME
- **nvim-ufo** - Advanced folding
- **harpoon** - Quick file navigation

### Editor Enhancement
- **mini.nvim** - Multiple utilities (comment, surround, trailspace, splitjoin)
- **auto-pairs** - Auto-close brackets
- **vim-maximizer** - Maximize/minimize splits
- **undotree** - Undo history visualizer
- **multi-cursor** - Multi-cursor editing

### Language-Specific
- **java.lua** - Java (JDTLS) support
- **typescript-tools** - Enhanced TypeScript/JavaScript
- **rust-analyzer** - Rust support
- **tailwind-tools** - Tailwind CSS utilities
- **emmet** - HTML/CSS abbreviations

### AI & Utilities
- **avante** - AI assistant integration
- **snacks.nvim** - Modern picker/input system
- **image-support** - Paste images from clipboard
- **render-markdown** - Markdown preview in editor

## 🚀 Quick Start

### Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this config
git clone <your-repo> ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

### First Launch

1. Lazy.nvim will automatically install all plugins
2. Mason will install LSP servers, formatters, and linters
3. Restart Neovim after installation completes

### Post-Installation

**Install language servers:**
```vim
:Mason
```

**Check health:**
```vim
:checkhealth
```

**Update plugins:**
```vim
:Lazy update
```

## 🎨 Changing Themes

### Method 1: Quick Switch
Edit `lua/current-theme.lua`:
```lua
vim.cmd("colorscheme tokyonight")
-- Options: tokyonight, rose-pine, gruvbox, kanagawa
```

### Method 2: Via Telescope
Press `<leader>ft` to open theme switcher

### Method 3: Configure Settings
Edit `lua/sethy/config.lua`:
```lua
M.colorscheme = {
  name = "gruvbox",
  transparent = false,
}
```

## 🛠️ Customization Tips

### Add a New Plugin

1. Create a new file in `lua/sethy/plugins/`:
   ```lua
   -- lua/sethy/plugins/my-plugin.lua
   return {
     "username/plugin-name",
     config = function()
       require("plugin-name").setup({
         -- config here
       })
     end,
   }
   ```

2. Restart Neovim or run `:Lazy sync`

### Modify Keybindings

Edit `lua/sethy/core/keymaps.lua`:
```lua
keymap.set("n", "<your-key>", "<your-command>", { desc = "Description" })
```

### Add Language Server

1. Edit `lua/sethy/config.lua`:
   ```lua
   M.lsp = {
     servers = {
       -- ... existing servers
       "your_new_server",
     },
   }
   ```

2. Edit `lua/sethy/plugins/lsp/mason.lua` (ensure_installed)
3. Restart Neovim

### Disable a Feature

Most features can be toggled in `lua/sethy/config.lua`:
```lua
M.utils = {
  trim_whitespace = false,  -- Disable auto-trim
  highlight_yank = false,   -- Disable yank highlight
}
```

## 🐛 Troubleshooting

### LSP Not Working
```vim
:LspInfo                    " Check LSP status
:Mason                      " Ensure servers installed
:checkhealth                " Run health check
```

### Plugins Not Loading
```vim
:Lazy                       " Open plugin manager
:Lazy sync                  " Sync/update plugins
:Lazy clean                 " Remove unused plugins
```

### Performance Issues
- Disable unused plugins in their config files
- Reduce `updatetime` in config.lua
- Check `:checkhealth` for issues

### Font Not Showing
- Ensure Nerd Font is installed
- Update font name in `config.lua`
- Restart terminal/GUI client

## 📝 Recent Improvements

✅ **Removed duplicates:**
- Deleted `oil.lua` (unused, using nvim-tree)
- Deleted `surround.lua` (using mini.surround instead)
- Cleaned up commented code in mini.lua

✅ **LazyVim-style statusline:**
- Modern, clean design
- Diagnostics display
- LSP client names
- Global statusline option

✅ **Centralized configuration:**
- New `config.lua` for easy tweaking
- All common settings in one place
- Better documentation

✅ **Added helpful autocmds:**
- Highlight on yank
- Auto-trim trailing whitespace
- Auto-create parent directories
- Resize splits on window resize
- Close certain windows with 'q'
- Go to last location when opening files
- Better terminal behavior
- Spell check for markdown/git commits

✅ **Fixed Lua diagnostics:**
- Added `.luarc.json` for proper LSP configuration
- Eliminated false "undefined vim" warnings

## 📚 Resources

- [Lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [LazyVim](https://www.lazyvim.org/) - Inspiration for statusline
- [Mason.nvim](https://github.com/williamboman/mason.nvim) - LSP installer
- [Telescope](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [Neovim Documentation](https://neovim.io/doc/)

## 🤝 Contributing

Feel free to customize this configuration to your needs! If you find improvements or have suggestions, consider:

1. Documenting your changes
2. Keeping the config modular
3. Using the centralized `config.lua` when possible

---

**Happy Vimming! 🚀**
