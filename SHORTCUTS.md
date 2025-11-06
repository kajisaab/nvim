# 🎯 Complete Neovim Shortcuts Cheatsheet

**Leader key:** `Space`

---

## 🧭 Navigation & Go-to Commands

### LSP Navigation (Code Intelligence)

| Shortcut | Action | Description |
|----------|--------|-------------|
| **`gd`** | **Go to Definition** | Jump to where function/variable is defined ⭐ |
| `gD` | Go to Declaration | Jump to declaration |
| `gr` | Show References | Show all places using this symbol |
| `gI` | Show Implementations | Show implementations of interface |
| `gy` | Show Type Definition | Show type definition |
| `K` | Hover Documentation | Show docs for symbol under cursor |
| `Ctrl-o` | Jump Back | Return to previous location |
| `Ctrl-i` | Jump Forward | Go forward in jump history |

**Example:** Place cursor on `getConversationHistory` → Press `gd` → Jumps to function definition!

---

## 💾 Save & Buffer Management

### Save Files

| Shortcut | Action |
|----------|--------|
| `Ctrl+S` | Quick save (works in insert & normal mode) ⭐ |
| `Space w` | Save current file |
| `Space W` | Save ALL files |

### Navigate Buffers (Open Files)

| Shortcut | Action |
|----------|--------|
| `Tab` | Next buffer ⭐ |
| `Shift+Tab` | Previous buffer ⭐ |
| `Shift+L` | Next buffer (alternative) |
| `Shift+H` | Previous buffer (alternative) |
| `Space bb` | List all buffers (searchable) |
| `Space bp` | Pick buffer interactively |

### Close Buffers

| Shortcut | Action |
|----------|--------|
| `Space x` | Close current buffer ⭐ |
| `Space X` | Close all OTHER buffers |
| `Space bP` | Pin/unpin buffer |
| `Space bs` | Sort buffers by directory |

---

## 🔍 Search & Find

| Shortcut | Action |
|----------|--------|
| `/` | Search forward (with wilder popup) |
| `?` | Search backward |
| `n` | Next search result |
| `N` | Previous search result |
| `Ctrl+C` | Clear search highlighting |
| `Space ff` | Find files (Telescope) |
| `Space fg` | Find text in files (grep) |
| `Space fb` | Find in current buffer |

---

## 📝 Editing

### Basic Editing

| Shortcut | Action |
|----------|--------|
| `jk` | Exit insert mode (instead of Esc) |
| `V` then `J` | Move selected lines down |
| `V` then `K` | Move selected lines up |
| `<` (visual) | Indent left |
| `>` (visual) | Indent right |
| `Space f` | Format code (LSP) |

### Copy/Paste/Delete

| Shortcut | Action |
|----------|--------|
| `Space p` | Paste without losing clipboard (visual) |
| `Space Y` | Copy to system clipboard |
| `Space dd` | Delete without yanking ⭐ |
| `x` | Delete char without yanking |

### Find & Replace

| Shortcut | Action |
|----------|--------|
| `Space s` | Replace word under cursor globally |
| `Space sr` | Replace with confirmation |
| `Space s` (visual) | Replace in selection |

---

## 🐛 Diagnostics & LSP

### View Diagnostics

| Shortcut | Action |
|----------|--------|
| `Space d` | Show diagnostic for current line ⭐ |
| `Space D` | Show all diagnostics in file |
| `Space lx` | Toggle diagnostics on/off |
| `[d` | Go to previous diagnostic |
| `]d` | Go to next diagnostic |

### Code Actions

| Shortcut | Action |
|----------|--------|
| `Space vca` | Show code actions |
| `Space cf` | Quick fix |
| `Space cm` | Implement interface methods |
| `Space rn` | Rename symbol |
| `Space ca` | Add missing imports (TS/JS) |
| `Space co` | Organize imports |
| `Space cr` | Remove unused imports |
| `Space l` | Trigger linting manually |

### LSP Management

| Shortcut | Action |
|----------|--------|
| `Space rs` | Restart LSP |
| `:LspInfo` | Show LSP info |
| `:Mason` | Open Mason (LSP installer) |

---

## 🌿 Git Commands

### Git Basics

| Shortcut | Action |
|----------|--------|
| `Space gg` | Open Git (Fugitive) |
| `Space lg` | Open LazyGit |

### Git Hunks (Changes)

| Shortcut | Action |
|----------|--------|
| `]h` | Next hunk |
| `[h` | Previous hunk |
| `Space gs` | Stage hunk |
| `Space gr` | Reset hunk |
| `Space gS` | Stage entire buffer |
| `Space gR` | Reset entire buffer |
| `Space gu` | Undo stage hunk |
| `Space gp` | Preview hunk |

### Git Diff & Blame

| Shortcut | Action |
|----------|--------|
| `Space gh` | Git diff (changed from gd) ⭐ |
| `Space gH` | Git diff ~ |
| `Space gbl` | Blame line (full) |
| `Space gB` | Toggle line blame |

### Git Diffview

| Shortcut | Action |
|----------|--------|
| `Space gdo` | Open Diffview |
| `Space gdc` | Close Diffview |
| `Space gdh` | File history |
| `Space gdf` | Current file history |
| `Space gdr` | Refresh Diffview |

### Git (in Fugitive buffer)

| Shortcut | Action |
|----------|--------|
| `Space P` | Git push |
| `Space p` | Git pull --rebase |
| `Space t` | Git push -u origin |

---

## 📁 File Explorer (NvimTree)

| Shortcut | Action |
|----------|--------|
| `Space e` | Toggle file explorer |
| `Space ee` | Focus file explorer |
| `Space ef` | Find current file in tree |
| `Space ec` | Collapse all folders |
| `Space er` | Refresh tree |

**Inside NvimTree:**
- `a` - Create file/folder
- `d` - Delete
- `r` - Rename
- `x` - Cut
- `c` - Copy
- `p` - Paste
- `y` - Copy name
- `Y` - Copy path

---

## 🪟 Window & Tab Management

### Splits

| Shortcut | Action |
|----------|--------|
| `Space sv` | Split vertically |
| `Space sh` | Split horizontally |
| `Space se` | Make splits equal size |
| `Space sx` | Close current split |
| `Ctrl+h/j/k/l` | Navigate between splits |

### Tabs

| Shortcut | Action |
|----------|--------|
| `Space to` | Open new tab |
| `Space tx` | Close current tab |
| `Space tn` | Next tab |
| `Space tp` | Previous tab |
| `Space tf` | Open current buffer in new tab |

### Window Utilities

| Shortcut | Action |
|----------|--------|
| `Space sm` | Maximize/minimize toggle |
| `Space tm` | New tmux session |

---

## 🤖 AI Assistant (Avante)

| Shortcut | Action |
|----------|--------|
| `Space aa` | Open AI chat ⭐ |
| `Space ar` | Refresh/retry |
| `Space ae` | Edit with AI |
| `Enter` | Submit message (in chat) |
| `Ctrl+S` | Submit (insert mode) |
| `a` | Apply AI suggestion at cursor |
| `A` | Apply all suggestions |
| `Tab` | Switch windows in sidebar |

**Usage:** Select code → `Space aa` → Ask question → AI responds!

---

## 🔧 Utilities

### File Operations

| Shortcut | Action |
|----------|--------|
| `Space xx` | Make file executable (chmod +x) |
| `Space fp` | Copy file path to clipboard |

### Code Folding

| Shortcut | Action |
|----------|--------|
| `za` | Toggle fold |
| `zo` | Open fold |
| `zc` | Close fold |
| `zR` | Open all folds |
| `zM` | Close all folds |

### Misc

| Shortcut | Action |
|----------|--------|
| `Space ?` | Open this shortcuts file ⭐ |
| `Q` | No operation (disabled) |
| `Ctrl+U` | Page up (centered) |
| `Ctrl+B` | Page down (centered) |
| `J` | Join lines |

---

## 🎨 Special Plugins

### Harpoon (Quick File Navigation)

| Shortcut | Action |
|----------|--------|
| `Space h` | Toggle Harpoon menu |
| `Space a` | Add file to Harpoon |
| `Ctrl+1/2/3/4` | Jump to Harpoon file 1/2/3/4 |

### UndoTree

| Shortcut | Action |
|----------|--------|
| `Space u` | Toggle undo tree |

### Trouble (Diagnostics Panel)

| Shortcut | Action |
|----------|--------|
| `Space tt` | Toggle Trouble |
| `Space td` | Document diagnostics |
| `Space tw` | Workspace diagnostics |

### Todo Comments

| Shortcut | Action |
|----------|--------|
| `Space ft` | Find TODOs |
| `]t` | Next TODO |
| `[t` | Previous TODO |

---

## ⚡ Quick Reference Card

### Most Used Shortcuts

```
Navigation:
  gd          - Go to definition ⭐
  gr          - Show references
  K           - Show docs
  Ctrl-o      - Jump back

Save/Buffers:
  Ctrl+S      - Save ⭐
  Tab         - Next buffer
  Space x     - Close buffer

Search:
  Space ff    - Find files
  Space fg    - Grep text
  /           - Search in file

Diagnostics:
  Space d     - Show error
  Space vca   - Code actions
  Space rn    - Rename

Git:
  Space gg    - Git status
  Space gh    - Git diff
  Space gs    - Stage hunk

AI:
  Space aa    - Ask AI ⭐
```

---

## 🔑 Fixed Conflicts

The following conflicts were resolved:

| Old | New | Purpose |
|-----|-----|---------|
| `Space gd` | `Space gh` | Git diff (avoid conflict with gd) |
| `Space d` | `Space dd` | Delete without yanking (avoid conflict with diagnostics) |
| `Space x` | `Space xx` | Make file executable (avoid conflict with close buffer) |

**Key Changes:**
- **`gd`** - Now ONLY for "Go to Definition" (LSP) ✅
- **`Space d`** - Now ONLY for showing diagnostics ✅
- **`Space x`** - Now ONLY for closing buffer ✅

---

## 💡 Pro Tips

1. **Go to definition:** Place cursor on function name → Press `gd` → Jump to definition
2. **Jump back:** After jumping with `gd`, press `Ctrl-o` to return
3. **Save all quickly:** Press `Space W` (capital W) to save all files
4. **Navigate buffers:** Use `Tab` and `Shift+Tab` like browser tabs
5. **See all errors:** Press `Space D` for diagnostics list
6. **Ask AI about code:** Select code → `Space aa` → Ask question
7. **Find anything:** `Space ff` for files, `Space fg` for text
8. **Git workflow:** `Space gs` (stage) → `Space gg` (commit)
9. **Real-time errors:** Diagnostics now show WHILE typing in insert mode!
10. **Unsaved files:** Look for orange dot (●) in bufferline at top

---

## 📚 Learn More

- `:help <command>` - Vim help for any command
- `:Telescope keymaps` - See ALL keymaps interactively
- `:checkhealth` - Check Neovim health
- `:LspInfo` - Check LSP status
- `:Mason` - Manage LSP servers & tools
- `Space ?` - Open this shortcuts file!

---

## 🆘 Troubleshooting

**Diagnostics not showing?**
- Run `:LspInfo` to check if LSP is attached
- Run `:Mason` to check if tools are installed
- Check if Node.js is installed: `node --version`

**`gd` not working?**
- Make sure you're on a function/variable name
- Check LSP is attached: `:LspInfo`
- Try restarting LSP: `Space rs`

**AI not working?**
- Check API key is set: `echo $ANTHROPIC_API_KEY`
- Try `:Lazy` to see if avante.nvim is loaded

---

**Config Location:** `~/.config/nvim/`

**Last Updated:** After fixing all keyboard conflicts

**Your Leader Key:** `Space` (this means "Space" when you see `<leader>`)
