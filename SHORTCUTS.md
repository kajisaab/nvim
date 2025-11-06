# Essential Neovim Shortcuts Guide

## 🎯 Multi-Cursor (VSCode-like)

| Keybinding | Action | VSCode Equivalent |
|------------|--------|-------------------|
| `<C-d>` | Select next occurrence | `Ctrl+D` |
| `<C-x>` | Skip current, find next | `Ctrl+K, Ctrl+D` |
| `<leader>A` | Select ALL occurrences | `Ctrl+Shift+L` |
| `<Alt-Up>` | Add cursor above | `Alt+Up` |
| `<Alt-Down>` | Add cursor below | `Alt+Down` |
| `<Tab>` | Switch between cursor/extend mode | (in multi-cursor mode) |
| `<Esc>` | Exit multi-cursor mode | `Esc` |

**Example:** Place cursor on `userName` → Press `<C-d>` repeatedly → Edit all at once!

**Note:** After selecting with `<C-d>`, you can:
- Press `c` to change (delete and insert)
- Press `I` to insert at the beginning
- Press `A` to insert at the end
- Press any edit command

---

## 🗑️ Delete Operations

### Basic Deletes
| Command | Action |
|---------|--------|
| `dd` | Delete current line |
| `5dd` | Delete 5 lines |
| `dw` | Delete word |
| `diw` | Delete inner word (whole word) |
| `D` or `d$` | Delete to end of line |
| `d0` | Delete to start of line |

### Smart Deletes (Text Objects)
| Command | Action | Example |
|---------|--------|---------|
| `di"` | Delete inside quotes | `"hello"` → `` |
| `di'` | Delete inside single quotes | `'hello'` → `''` |
| `di(` | Delete inside parentheses | `(hello)` → `()` |
| `di{` | Delete inside braces | `{hello}` → `{}` |
| `di[` | Delete inside brackets | `[hello]` → `[]` |
| `dit` | Delete inside HTML tag | `<div>hi</div>` → `<div></div>` |

### Visual Mode Delete

**Delete Full Lines:**
1. `V` - Select line(s) with j/k (up/down)
2. `d` - Delete selected lines

**Delete Partial Text:**
1. `v` - Enter visual character mode
2. Move with h/j/k/l or w/b to select text
3. `d` - Delete only selected portion

**Delete Block/Column:**
1. `<C-v>` - Enter visual block mode
2. Select rectangular area
3. `d` - Delete block

**Quick Visual Deletes:**
| Command | Action |
|---------|--------|
| `viwdd` | Select word and delete |
| `vi"d` | Delete text inside quotes |
| `vi(d` | Delete text inside parentheses |
| `Vjjd` | Select and delete 3 lines |

---

## 📍 Navigation

### Line Navigation
| Command | Action |
|---------|--------|
| `0` | Start of line (column 0) |
| `^` | First non-blank character |
| `$` | End of line |
| `I` | Insert at start of line |
| `A` | Insert at end of line |

### File Navigation
| Command | Action |
|---------|--------|
| `gg` | Go to start of file |
| `G` | Go to end of file |
| `50G` | Go to line 50 |
| `<C-u>` | Scroll up half page (centered) |
| `<C-b>` | Scroll up full page (centered) |
| `<C-f>` | Scroll down full page |

### Word Navigation
| Command | Action |
|---------|--------|
| `w` | Next word |
| `b` | Previous word |
| `e` | End of word |
| `W` | Next WORD (space-separated) |
| `B` | Previous WORD |

---

## 🔍 Find and Search

### Basic Search
| Command | Action |
|---------|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `*` | Find word under cursor (forward) |
| `#` | Find word under cursor (backward) |
| `<C-c>` | Clear search highlights |

### Find and Replace
| Command | Action | Example |
|---------|--------|---------|
| `<leader>s` | Replace word globally | Place cursor on word → type new word |
| `<leader>sr` | Replace with confirmation | Interactive y/n/a/q |
| `:%s/old/new/g` | Replace all in file | `:%s/foo/bar/g` |
| `:%s/old/new/gc` | Replace with confirm | Press y/n for each |
| `:'<,'>s/old/new/g` | Replace in selection | Visual select → command |

**Confirmation options:**
- `y` - Yes, replace
- `n` - No, skip
- `a` - Replace All remaining
- `q` - Quit

---

## ✂️ Select Text (Visual Mode)

### Enter Visual Mode
| Command | Action |
|---------|--------|
| `v` | Character-wise selection |
| `V` | Line-wise selection |
| `<C-v>` | Block/column selection |

### Text Objects (with `v` or `d`)
| Command | Action | Example |
|---------|--------|---------|
| `viw` | Select inner word | Selects word under cursor |
| `vaw` | Select a word + spaces | Word with surrounding space |
| `vi"` | Select inside quotes | Text between `"..."` |
| `vi(` | Select inside parens | Text between `(...)` |
| `vi{` | Select inside braces | Text between `{...}` |
| `vit` | Select inside tag | HTML tag contents |
| `ggVG` | Select entire file | From top to bottom |

---

## 📋 Copy, Cut, Paste

### Yank (Copy)
| Command | Action |
|---------|--------|
| `yy` | Copy current line |
| `5yy` | Copy 5 lines |
| `yiw` | Copy inner word |
| `y$` | Copy to end of line |
| `<leader>Y` | Copy line to system clipboard |

### Paste
| Command | Action |
|---------|--------|
| `p` | Paste after cursor |
| `P` | Paste before cursor |
| `<leader>p` | Paste without overwriting register |

### Special Delete (No Copy)
| Command | Action |
|---------|--------|
| `<leader>d` | Delete without yanking |
| `x` | Delete character (without yanking) |

---

## 🧬 LSP Code Actions

### Auto-Complete & Imports
| Keybinding | Action |
|------------|--------|
| `<Tab>` | Accept completion / Next item |
| `<C-j>` / `<C-k>` | Navigate completion menu |
| `<C-e>` | Close completion menu |
| `<leader>ca` | Add missing import |
| `<leader>cA` | Add ALL missing imports |
| `<leader>co` | Organize imports |
| `<leader>cr` | Remove unused imports |

### Code Generation
| Keybinding | Action |
|------------|--------|
| `<leader>cm` | Implement interface methods |
| `<leader>cf` | Quick fix / code actions |
| `<leader>vca` | View all code actions |
| `<leader>cg` | Generate getters/setters (Java) |
| `<leader>cc` | Generate constructor (Java) |

### Navigation
| Keybinding | Action |
|------------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Show references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `K` | Show hover documentation |
| `<leader>d` | Show line diagnostics |
| `<leader>D` | Show buffer diagnostics |

### Refactoring
| Keybinding | Action |
|------------|--------|
| `<leader>rn` | Rename symbol |
| `<leader>rs` | Restart LSP |

---

## 📝 Editing

### Insert Mode
| Command | Action |
|---------|--------|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `I` | Insert at start of line |
| `A` | Insert at end of line |
| `o` | Open new line below |
| `O` | Open new line above |
| `jk` | Exit insert mode (custom) |

### Change Operations
| Command | Action |
|---------|--------|
| `ciw` | Change inner word |
| `ci"` | Change inside quotes |
| `ci(` | Change inside parentheses |
| `cc` | Change entire line |
| `C` | Change to end of line |

### Undo/Redo
| Command | Action |
|---------|--------|
| `u` | Undo |
| `<C-r>` | Redo |

---

## 🎨 Visual Mode Operations

### Move Lines
| Command | Action | Mode |
|---------|--------|------|
| `J` | Move line down | Visual |
| `K` | Move line up | Visual |

### Indentation
| Command | Action |
|---------|--------|
| `>` | Indent right (stays in visual) |
| `<` | Indent left (stays in visual) |
| `>>` | Indent line right (normal mode) |
| `<<` | Indent line left (normal mode) |

---

## 🪟 Window & Split Management

### Splits
| Keybinding | Action |
|------------|--------|
| `<leader>sv` | Split vertically |
| `<leader>sh` | Split horizontally |
| `<leader>se` | Make splits equal size |
| `<leader>sx` | Close current split |
| `<C-w>w` | Switch between splits |
| `<C-w>h/j/k/l` | Navigate splits |

### Tabs
| Keybinding | Action |
|------------|--------|
| `<leader>to` | Open new tab |
| `<leader>tx` | Close current tab |
| `<leader>tn` | Next tab |
| `<leader>tp` | Previous tab |
| `<leader>tf` | Open current buffer in new tab |

---

## 🔧 Formatting

| Keybinding | Action |
|------------|--------|
| `<leader>mp` | Format file with Prettier |
| `<leader>f` | Format with LSP |
| `:w` | Save (auto-format on save enabled) |

---

## 🗂️ File Operations

| Keybinding | Action |
|------------|--------|
| `<leader>fp` | Copy file path to clipboard |
| `<leader>x` | Make file executable |

---

## 🎛️ Utilities

| Keybinding | Action |
|------------|--------|
| `<leader>lx` | Toggle LSP diagnostics visibility |
| `<leader>tm` | New tmux session |
| `<C-c>` | Clear search highlights |

---

## 📦 Multi-Cursor Examples

### Example 1: Rename Variables
```javascript
const userName = "John";
const userName = getUserName();
console.log(userName);

// 1. Cursor on 'userName'
// 2. Press <C-d> three times
// 3. Press 'c' to change
// 4. Type new name
```

### Example 2: Add Semicolons
```javascript
const a = 1
const b = 2
const c = 3

// 1. Cursor on first line
// 2. Press <C-Down> twice
// 3. Press 'A' (end of line)
// 4. Type ';'
```

### Example 3: Column Editing
```
user1
user2
user3

// 1. <C-v> (visual block)
// 2. Select column with j/k
// 3. Press 'I' to insert
// 4. Type 'const '
// 5. Press <Esc>
```

---

## 🎯 Quick Reference Card

```
┌─────────────────────────────────────────────────────┐
│  ESSENTIAL SHORTCUTS                                │
├─────────────────────────────────────────────────────┤
│  DELETE LINE:          dd                           │
│  SELECT LINE:          V                            │
│  START/END LINE:       0 / $                        │
│  FIND:                 /pattern                     │
│  REPLACE:              <leader>s                    │
│  MULTI-SELECT:         <C-d>                        │
│  IMPLEMENT INTERFACE:  <leader>cm                   │
│  AUTO IMPORT:          <Tab> on completion          │
│  ADD IMPORT:           <leader>ca                   │
│  GO TO DEFINITION:     gd                           │
│  RENAME:               <leader>rn                   │
│  FORMAT:               <leader>mp                   │
│  UNDO/REDO:            u / <C-r>                    │
└─────────────────────────────────────────────────────┘
```

---

## 💡 Pro Tips

1. **Combine commands:** `d5w` = delete 5 words, `y3j` = yank 3 lines down
2. **Repeat last action:** `.` (dot) repeats your last change
3. **Record macros:** `qa` = start recording to register 'a', `q` = stop, `@a` = replay
4. **Line numbers:** `:set number` or `:set relativenumber`
5. **Visual block:** `<C-v>` is powerful for column editing
6. **Text objects:** Learn `i` (inner) and `a` (around) - works with w, ", (, {, [, t

---

## 🚀 Learn More

- Built-in help: `:help <command>` (e.g., `:help dd`)
- Vim tutor: Run `vimtutor` in terminal
- This config location: `~/.config/nvim/`

---

## 🔧 Troubleshooting

### Multi-Cursor Not Working?

1. **Check if plugin is installed:**
   ```vim
   :Lazy
   ```
   Look for "vim-visual-multi" in the list

2. **Reload Neovim:**
   ```vim
   :Lazy sync
   :q
   ```
   Then restart Neovim

3. **Test multi-cursor:**
   - Type: `test test test` on a line
   - Place cursor on first "test"
   - Press `<C-d>` - you should see all "test" highlighted
   - Type "hello" - all should change

4. **Check for conflicts:**
   ```vim
   :verbose map <C-d>
   ```
   Should show vim-visual-multi mapping

### Import Not Working?

1. **Check LSP is running:**
   ```vim
   :LspInfo
   ```

2. **Check if TypeScript server is attached:**
   Should see "typescript-tools" or "ts_ls"

3. **Restart LSP:**
   ```vim
   :LspRestart
   ```

---

**Last Updated:** 2025
**Your Leader Key:** `Space`

**Quick Help:** Press `<leader>?` to open this file anytime!
