# Essential Neovim Shortcuts - Quick Reference

*The most frequently used shortcuts for daily productivity*

## 🔄 Undo/Redo
| Key | Action | Description |
|-----|--------|-------------|
| `u` | **Undo** | Undo last change |
| `<C-r>` | **Redo** | Redo last undone change |
| `<leader>u` | **Visual Undotree** | See full undo history tree |

## 🔍 Search & Navigation Within File
| Key | Action | Description |
|-----|--------|-------------|
| `/pattern` | **Search Forward** | Search and auto-jump to first match |
| `?pattern` | **Search Backward** | Search backward for pattern |
| `n` | **Next Match** | Jump to next search result |
| `N` | **Previous Match** | Jump to previous search result |
| `*` | **Search Word** | Search word under cursor forward |
| `#` | **Search Word Back** | Search word under cursor backward |
| `<C-c>` | **Clear Search** | Clear search highlighting |

## 🎯 Function/Code Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | **Go to Definition** | Jump to function/variable definition |
| `gR` | **Show References** | Show all references to symbol |
| `gi` | **Go to Implementation** | Jump to implementation |
| `gt` | **Go to Type Definition** | Jump to type definition |
| `K` | **Show Documentation** | Show function docs (hover) |

## ⬅️➡️ Jump Back/Forward (Navigation History)
| Key | Action | Description |
|-----|--------|-------------|
| `<C-o>` | **Jump Back** | Go back to previous location |
| `<C-i>` | **Jump Forward** | Go forward in jump history |
| `<C-^>` | **Last File** | Switch to last opened file |
| `''` | **Last Position** | Jump to last cursor position |
| `'.` | **Last Change** | Jump to last edit location |

## 🚀 Quick File Switching (Harpoon)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>a` | **Add to Harpoon** | Mark current file for quick access |
| `<C-e>` | **Harpoon Menu** | Open quick file switcher |
| `<C-h>` | **Quick File 1** | Jump to harpoon file 1 |
| `<C-t>` | **Quick File 2** | Jump to harpoon file 2 |
| `<C-n>` | **Quick File 3** | Jump to harpoon file 3 |
| `<C-s>` | **Quick File 4** | Jump to harpoon file 4 |

## 📁 File Management Essentials
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ff` | **Find Files** | Fuzzy find files in project |
| `<leader>fs` | **Search Text** | Live grep across project |
| `<leader>fc` | **Search Word** | Search word under cursor in project |
| `<leader>fr` | **Recent Files** | Find recently opened files |
| `<leader>ee` | **File Explorer** | Toggle file tree |

## 🔀 Git Essentials (NEW!)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>lg` | **LazyGit** | Complete Git visual interface |
| `<leader>gdo` | **Diff View** | Open visual diff viewer |
| `<leader>gco` | **Choose Ours** | Resolve conflict (keep your changes) |
| `<leader>gct` | **Choose Theirs** | Resolve conflict (keep incoming) |
| `<leader>gcn` | **Next Conflict** | Jump to next git conflict |
| `<leader>hs` | **Stage Hunk** | Stage current git change |

## ⚡ Most Common Workflows

### 🔧 **Function Navigation Workflow**
```
1. Place cursor on function name
2. `gd` → Jump to definition
3. Read/edit the function
4. `<C-o>` → Jump back to where you started
```

### 🔍 **Search & Jump Workflow**
```
1. `/functionName` → Search for function
2. `n` → Cycle through matches
3. `<Enter>` → Land on desired match
4. `<C-o>` → Return to original location
```

### 📂 **Project Search Workflow**
```
1. Place cursor on word/function
2. `<leader>fc` → Search across entire project
3. Select result from list
4. `<C-o>` → Go back when done
```

### 🏃 **Quick File Switching**
```
1. `<leader>a` → Add important files to Harpoon
2. `<C-h>`, `<C-t>`, `<C-n>`, `<C-s>` → Instant switching
```

## 🎯 Line-Level Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `f{char}` | **Find Character** | Jump to character on current line |
| `F{char}` | **Find Backward** | Jump to character backward on line |
| `;` | **Repeat Find** | Repeat last f/F command |
| `,` | **Reverse Find** | Repeat last f/F in opposite direction |

## 📝 Word Movement
| Key | Action | Description |
|-----|--------|-------------|
| `w` | **Next Word** | Jump to start of next word |
| `b` | **Previous Word** | Jump to start of previous word |
| `e` | **End of Word** | Jump to end of current word |

## 💡 **Power User Tips**

- **Combine movements**: `d2w` (delete 2 words), `c3j` (change 3 lines down)
- **Use marks**: `ma` (set mark a), `'a` (jump to mark a)
- **Visual selection + search**: Select text, then `*` to search for it
- **Jump list is your friend**: `<C-o>` and `<C-i>` work across files
- **Harpoon for projects**: Mark 3-4 most important files for instant access

---

*💡 Tip: Print this page and keep it handy until these become muscle memory!*

**Leader Key**: `<Space>` (spacebar)