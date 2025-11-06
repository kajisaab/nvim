# Advanced Navigation & Search in Neovim

*Advanced techniques for power users and complex codebases*

## 🔍 Advanced Search Techniques

### Pattern Search with Regex
| Pattern | Description | Example |
|---------|-------------|---------|
| `/\cpattern` | Case-insensitive search | `/\cFunction` finds "function", "FUNCTION", "Function" |
| `/\Cpattern` | Case-sensitive search | `/\CFunction` finds only "Function" |
| `/pattern\c` | Case-insensitive (suffix) | `/function\c` |
| `/^pattern` | Search at line start | `/^class` finds "class" at beginning of line |
| `/pattern$` | Search at line end | `/;$` finds lines ending with semicolon |
| `/\<word\>` | Whole word search | `/\<var\>` finds "var" but not "variable" |

### Search with Quantifiers
| Pattern | Description | Example |
|---------|-------------|---------|
| `/pattern*` | Zero or more | `/test*` finds "tes", "test", "testtt" |
| `/pattern\+` | One or more | `/test\+` finds "test", "testtt" but not "tes" |
| `/pattern\?` | Zero or one | `/tests\?` finds "test" and "tests" |
| `/pattern\{3}` | Exactly 3 | `/a\{3}` finds "aaa" |
| `/pattern\{3,5}` | 3 to 5 | `/a\{3,5}` finds "aaa", "aaaa", "aaaaa" |

## 🎯 LSP Advanced Navigation

### Code Intelligence
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>vca` | **Code Actions** | Show available code actions for cursor position |
| `<leader>rn` | **Smart Rename** | Rename symbol across entire project |
| `<leader>D` | **Buffer Diagnostics** | Show all diagnostics for current file |
| `<leader>d` | **Line Diagnostics** | Show diagnostics for current line |
| `]d` | **Next Diagnostic** | Jump to next diagnostic/error |
| `[d` | **Previous Diagnostic** | Jump to previous diagnostic/error |

### Telescope Advanced Search
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>fs` | **Live Grep** | Real-time search across project with preview |
| `<leader>fc` | **Grep Cursor Word** | Search word under cursor across project |
| `<leader>fb` | **Find Buffers** | Search through open buffers |
| `<leader>fh` | **Help Tags** | Search through help documentation |
| `<leader>fm` | **Find Marks** | Search through vim marks |
| `<leader>fk` | **Find Keymaps** | Search through available keymaps |

### Within Telescope Results
| Key | Action | Description |
|-----|--------|-------------|
| `<C-n>/<C-j>` | Next result | Move down in results |
| `<C-p>/<C-k>` | Previous result | Move up in results |
| `<C-u>` | Clear prompt | Clear search prompt |
| `<C-q>` | Send to quickfix | Send results to quickfix list |
| `<Tab>` | Toggle selection | Select/deselect multiple results |

## 🏷️ Marks & Bookmarks

### Local Marks (per file)
| Key | Action | Description |
|-----|--------|-------------|
| `ma` | **Set Mark 'a'** | Set local mark at current position |
| `'a` | **Jump to Mark 'a'** | Jump to line with mark 'a' |
| `` `a `` | **Jump to Exact Position** | Jump to exact character position of mark 'a' |
| `''` | **Previous Jump** | Jump to previous position |
| `` `` `` | **Last Edit** | Jump to last edit position |

### Global Marks (across files)
| Key | Action | Description |
|-----|--------|-------------|
| `mA` | **Set Global Mark 'A'** | Set global mark (A-Z) |
| `'A` | **Jump to Global Mark** | Jump to file and line with mark 'A' |
| `:marks` | **List All Marks** | Show all active marks |
| `:delmarks a` | **Delete Mark** | Delete specific mark |
| `:delmarks!` | **Delete All Local** | Delete all local marks |

## 🔄 Advanced Jump List Navigation

### Jump List Commands
| Key | Action | Description |
|-----|--------|-------------|
| `:jumps` | **Show Jump List** | Display jump history |
| `<C-o>` | **Older Jump** | Go to older position in jump list |
| `<C-i>` | **Newer Jump** | Go to newer position in jump list |
| `g;` | **Previous Change** | Jump to previous change location |
| `g,` | **Next Change** | Jump to next change location |

### Change List Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `:changes` | **Show Changes** | Display change list |
| `'.` | **Last Change** | Jump to last change position |
| `'^` | **Last Insert** | Jump to last insert position |

## 📂 Advanced File Operations

### Buffer Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `:ls` | **List Buffers** | Show all open buffers |
| `:b {number}` | **Buffer by Number** | Jump to buffer by number |
| `:b {partial}` | **Buffer by Name** | Jump to buffer by partial name |
| `<C-^>` | **Alternate Buffer** | Switch between current and previous buffer |
| `:bd` | **Delete Buffer** | Close current buffer |
| `:bd!` | **Force Delete** | Force close buffer (ignore changes) |

### Window Management
| Key | Action | Description |
|-----|--------|-------------|
| `<C-w>w` | **Next Window** | Cycle through windows |
| `<C-w>h/j/k/l` | **Move Between Windows** | Navigate to window in direction |
| `<C-w>r` | **Rotate Windows** | Rotate windows clockwise |
| `<C-w>T` | **Move to Tab** | Move current window to new tab |
| `<C-w>=` | **Equal Size** | Make all windows equal size |
| `<C-w>_` | **Maximize Height** | Maximize current window height |
| `<C-w>|` | **Maximize Width** | Maximize current window width |

## 🔧 Text Objects for Navigation

### Built-in Text Objects
| Key | Action | Description |
|-----|--------|-------------|
| `viw` | **Select Word** | Select inner word |
| `vaw` | **Select Word+Space** | Select word and surrounding whitespace |
| `vi"` | **Select Inside Quotes** | Select text inside quotes |
| `va"` | **Select Around Quotes** | Select quotes and text inside |
| `vi)` | **Select Inside Parens** | Select text inside parentheses |
| `va)` | **Select Around Parens** | Select parentheses and text inside |
| `vip` | **Select Paragraph** | Select current paragraph |
| `vit` | **Select Tag** | Select inside HTML/XML tag |

### Advanced Navigation with Text Objects
| Key | Action | Description |
|-----|--------|-------------|
| `cin"` | **Change Inside Quotes** | Change text inside quotes |
| `da)` | **Delete Around Parens** | Delete parentheses and contents |
| `yip` | **Yank Paragraph** | Copy current paragraph |

## 🎨 Visual Mode Navigation

### Visual Selection
| Key | Action | Description |
|-----|--------|-------------|
| `v` | **Character Visual** | Start character-wise visual selection |
| `V` | **Line Visual** | Start line-wise visual selection |
| `<C-v>` | **Block Visual** | Start block/column visual selection |
| `gv` | **Reselect** | Reselect last visual selection |
| `o` | **Other End** | Move to other end of selection |

### Visual Mode Commands
| Key | Action | Description |
|-----|--------|-------------|
| `*` | **Search Selection** | Search for visually selected text |
| `u` | **Lowercase** | Convert selection to lowercase |
| `U` | **Uppercase** | Convert selection to uppercase |
| `>` | **Indent** | Indent selected lines |
| `<` | **Unindent** | Unindent selected lines |

## 🚀 Pro Navigation Workflows

### 1. **Code Exploration Workflow**
```
1. `<leader>fs` → Search for concept/function name
2. Open result → `<C-o>` to mark starting point
3. `gd` → Go to definition
4. Explore related code → Use `*` to find usages
5. `<C-o>` → Return to search results
6. Try next result → Repeat
```

### 2. **Bug Hunting Workflow**
```
1. `/error` or `/bug` → Search for error keywords
2. `n` → Cycle through matches
3. `gd` → Jump to function definitions
4. `<leader>D` → Check diagnostics
5. `]d` → Jump through errors
6. `<C-o>` → Navigate back through investigation
```

### 3. **Refactoring Workflow**
```
1. Place cursor on function/variable
2. `<leader>rn` → Rename across project
3. `gR` → Check all references
4. `<leader>vca` → Look for code actions
5. Use visual selection + `*` to find patterns
```

### 4. **Learning New Codebase**
```
1. `<leader>ff` → Find main entry points
2. `<leader>a` → Add key files to Harpoon
3. `gd` → Follow function definitions
4. Use marks (`mA`, `mB`) → Bookmark important locations
5. `<leader>fs` → Search for key concepts
```

---

*🎯 Master these techniques to navigate any codebase like a pro!*