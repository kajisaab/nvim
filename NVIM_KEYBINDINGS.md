# Neovim Keybindings Reference Guide

## Leader Key
- **Leader**: `<Space>` (spacebar)
- **Local Leader**: `<Space>` (spacebar)

## Core Navigation & Editing

### Basic Movement
| Key | Action | Description |
|-----|--------|-------------|
| `J` (visual) | Move lines down | Move selected lines down in visual mode |
| `K` (visual) | Move lines up | Move selected lines up in visual mode |
| `J` (normal) | Join lines | Join line below with current line, keeping cursor position |
| `<C-d>` | Scroll down | Scroll down half-page with cursor centered |
| `<C-u>` | Scroll up | Scroll up half-page with cursor centered |
| `n` | Next search | Go to next search result, centered |
| `N` | Previous search | Go to previous search result, centered |

### Text Manipulation
| Key | Action | Description |
|-----|--------|-------------|
| `<` (visual) | Unindent | Unindent and keep selection |
| `>` (visual) | Indent | Indent and keep selection |
| `<leader>p` (visual) | Paste replace | Paste without overwriting clipboard |
| `p` (visual) | Paste | Paste and delete to black hole register |
| `<leader>Y` | Yank to system | Copy line to system clipboard |
| `<leader>d` | Delete to void | Delete without affecting clipboard |
| `x` | Delete char | Delete character without affecting clipboard |
| `<leader>s` | Replace word | Replace word under cursor globally |

### Quick Actions
| Key | Action | Description |
|-----|--------|-------------|
| `jk` (insert) | Exit insert | Quick escape from insert mode |
| `<C-c>` | Clear search | Clear search highlighting |
| `<leader>f` | Format | Format code using LSP |
| `Q` | Disabled | Q key disabled (no ex mode) |
| `<leader>x` | Make executable | Make current file executable |

## Window & Tab Management

### Splits
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>sv` | Split vertical | Split window vertically |
| `<leader>sh` | Split horizontal | Split window horizontally |
| `<leader>se` | Equal splits | Make splits equal size |
| `<leader>sx` | Close split | Close current split |

### Tabs
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>to` | Open tab | Open new tab |
| `<leader>tx` | Close tab | Close current tab |
| `<leader>tn` | Next tab | Go to next tab |
| `<leader>tp` | Previous tab | Go to previous tab |
| `<leader>tf` | Tab file | Open current file in new tab |

## File Management

### NvimTree
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ee` | Toggle tree | Toggle file explorer |
| `<leader>ef` | Focus tree | Focus on file explorer |
| `<leader>ec` | Collapse tree | Collapse file explorer |
| `<leader>er` | Refresh tree | Refresh file explorer |

### Oil.nvim (File Browser)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>-` | Open oil | Open parent directory in oil |

### Telescope (Fuzzy Finder)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ff` | Find files | Find files in project |
| `<leader>fr` | Recent files | Find recent files |
| `<leader>fs` | Live grep | Search text in files |
| `<leader>fc` | Grep cursor | Search word under cursor |
| `<leader>fb` | Find buffers | Find open buffers |
| `<leader>fh` | Help tags | Search help documentation |
| `<leader>fm` | Find marks | Find marks |
| `<leader>fk` | Find keymaps | Search keymaps |
| `<leader>fc` | Find commands | Search commands |
| `<leader>ft` | Builtin | Telescope builtin pickers |

## LSP (Language Server Protocol)

### Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `gR` | References | Show LSP references |
| `gD` | Declaration | Go to declaration |
| `gd` | Definition | Show LSP definitions |
| `gi` | Implementations | Show LSP implementations |
| `gt` | Type definitions | Show LSP type definitions |

### Code Actions
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>vca` | Code actions | See available code actions |
| `<leader>rn` | Rename | Smart rename symbol |
| `K` | Hover docs | Show documentation for symbol under cursor |
| `<C-h>` (insert) | Signature help | Show function signature help |

### Diagnostics
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>D` | Buffer diagnostics | Show diagnostics for current file |
| `<leader>d` | Line diagnostics | Show diagnostics for current line |
| `<leader>lx` | Toggle diagnostics | Toggle LSP diagnostics visibility |
| `<leader>li` | Organize imports | Add/organize imports |
| `<leader>rs` | Restart LSP | Restart LSP server |

## Git Integration

### Gitsigns
| Key | Action | Description |
|-----|--------|-------------|
| `]h` | Next hunk | Go to next git hunk |
| `[h` | Previous hunk | Go to previous git hunk |
| `<leader>hs` | Stage hunk | Stage current hunk |
| `<leader>hr` | Reset hunk | Reset current hunk |
| `<leader>hS` | Stage buffer | Stage entire buffer |
| `<leader>hu` | Undo stage | Undo stage hunk |
| `<leader>hR` | Reset buffer | Reset entire buffer |
| `<leader>hp` | Preview hunk | Preview hunk changes |
| `<leader>hb` | Blame line | Show git blame for line |
| `<leader>hd` | Diff this | Diff against index |
| `<leader>hD` | Diff cached | Diff against cached |
| `<leader>tb` | Toggle blame | Toggle current line blame |
| `<leader>td` | Toggle deleted | Toggle deleted lines view |

### Git Worktree
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gw` | Git worktrees | List git worktrees |
| `<leader>gm` | Create worktree | Create new git worktree |

## Code Tools

### Trouble (Diagnostics)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>xx` | Toggle trouble | Toggle trouble diagnostics |
| `<leader>xw` | Workspace diagnostics | Show workspace diagnostics |
| `<leader>xd` | Document diagnostics | Show document diagnostics |
| `<leader>xq` | Quickfix | Show quickfix list |
| `<leader>xl` | Location list | Show location list |
| `<leader>xt` | Todo comments | Show todo comments |

### Undotree
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>u` | Toggle undotree | Toggle undo tree visualization |

### Harpoon (Quick Navigation)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>a` | Add to harpoon | Add current file to harpoon |
| `<C-e>` | Toggle harpoon | Toggle harpoon quick menu |
| `<C-h>` | Harpoon file 1 | Go to harpoon file 1 |
| `<C-t>` | Harpoon file 2 | Go to harpoon file 2 |
| `<C-n>` | Harpoon file 3 | Go to harpoon file 3 |
| `<C-s>` | Harpoon file 4 | Go to harpoon file 4 |

## Sessions & Utilities

### Auto Session
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>wr` | Restore session | Restore session for cwd |
| `<leader>ws` | Save session | Save session for cwd |

### Utilities
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>fp` | Copy filepath | Copy file path to clipboard |
| `<C-f>` | Tmux sessionizer | Start new tmux session |

## Terminal Integration

### Terminal Popup
| Key | Action | Description |
|-----|--------|-------------|
| `<A-i>` | Toggle terminal | Toggle floating terminal |
| `<A-h>` | Horizontal terminal | Toggle horizontal terminal |
| `<A-v>` | Vertical terminal | Toggle vertical terminal |

## Specialized Tools

### Markdown
- Render-markdown plugin for enhanced markdown viewing
- Image support for viewing images in terminal

### Java Development
- JDTLS integration for Java development
- Automatic import organization on save

### Debugging
- DAP (Debug Adapter Protocol) support
- Debugging configurations for multiple languages

### Autocompletion
- nvim-cmp with multiple sources
- LuaSnip for snippets
- Emoji completion support

## Plugin-Specific Features

### Which-key
- Shows available keybindings when you start typing a sequence
- Helps discover new shortcuts

### Surround
- Quick text object manipulation for quotes, brackets, etc.

### Auto-pairs
- Automatic bracket and quote completion

### Lualine
- Enhanced status line with git info, LSP status, etc.

### Mini.nvim
- Various mini utilities for enhanced editing

---

*This configuration is optimized for web development with strong support for JavaScript/TypeScript, Go, Python, Java, and Lua.*