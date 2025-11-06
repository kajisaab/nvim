# Git Features & Conflict Resolution in Neovim

## 🚀 New Advanced Git Plugins Added

### 1. **LazyGit Integration**
Complete Git UI with visual interface and commands

### 2. **Git Conflict Resolution**
Easy conflict resolution with visual indicators

### 3. **DiffView**
Advanced diff viewer with side-by-side comparisons

### 4. **Enhanced GitSigns**
Improved git integration in buffers

---

## 🎯 **Git Visual Interface - LazyGit**

### **Main Command**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>lg` | **LazyGit** | Open LazyGit visual interface |

### **LazyGit Features:**
- 📊 **Visual Git Status** - See all changes at a glance
- 🌿 **Branch Management** - Create, switch, merge branches visually
- 📝 **Commit Interface** - Stage, unstage, commit with ease
- 📈 **Git History** - Browse commit history with visual tree
- 🔀 **Merge/Rebase** - Handle complex git operations
- 🏷️ **Tag Management** - Create and manage git tags
- 🌐 **Remote Operations** - Push, pull, fetch with visual feedback

### **LazyGit Navigation:**
- `j/k` - Navigate up/down
- `h/l` - Navigate between panels
- `<Space>` - Stage/unstage files
- `c` - Commit
- `P` - Push
- `p` - Pull
- `b` - Branch operations
- `q` - Quit LazyGit

---

## ⚔️ **Git Conflict Resolution**

### **Conflict Detection**
When git conflicts occur, you'll see visual indicators:
- 🔴 **Current Branch** (HEAD) - Your changes
- 🔵 **Incoming Branch** - Changes being merged
- ⚠️ **Conflict Markers** - Areas needing resolution

### **Conflict Resolution Commands**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gco` | **Choose Ours** | Keep current branch changes |
| `<leader>gct` | **Choose Theirs** | Keep incoming branch changes |
| `<leader>gcb` | **Choose Both** | Keep both sets of changes |
| `<leader>gc0` | **Choose None** | Reject both changes |
| `<leader>gcn` | **Next Conflict** | Jump to next conflict |
| `<leader>gcp` | **Previous Conflict** | Jump to previous conflict |
| `<leader>gcl` | **List Conflicts** | Show all conflicts in quickfix |

### **Conflict Resolution Workflow:**
```
1. Open conflicted file in nvim
2. <leader>gcl → See all conflicts
3. <leader>gcn → Navigate to first conflict
4. Choose resolution: <leader>gco/gct/gcb/gc0
5. Repeat for all conflicts
6. Save file and commit
```

---

## 🔍 **Advanced Diff Viewing - DiffView**

### **DiffView Commands**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gdo` | **Open DiffView** | Open diff view for current changes |
| `<leader>gdc` | **Close DiffView** | Close diff view |
| `<leader>gdh` | **File History** | Show git history for all files |
| `<leader>gdf` | **Current File History** | Show history for current file |
| `<leader>gdr` | **Refresh DiffView** | Refresh the diff view |

### **DiffView Features:**
- 📊 **Side-by-side Diff** - Compare changes visually
- 📁 **File Panel** - Navigate changed files easily
- 🕐 **History View** - Browse git history with diffs
- 🔀 **3-way Merge** - Handle merge conflicts visually
- 📋 **Commit Details** - See commit information and changes

### **DiffView Navigation:**
- `<Tab>` - Next file
- `<S-Tab>` - Previous file
- `]x` - Next conflict (in merge mode)
- `[x` - Previous conflict (in merge mode)
- `2do` - Choose OURS in 3-way diff
- `3do` - Choose THEIRS in 3-way diff
- `g?` - Show help

---

## 📝 **Enhanced GitSigns (Already Configured)**

### **Hunk Operations**
| Key | Action | Description |
|-----|--------|-------------|
| `]h` | **Next Hunk** | Jump to next change |
| `[h` | **Previous Hunk** | Jump to previous change |
| `<leader>hs` | **Stage Hunk** | Stage current change |
| `<leader>hr` | **Reset Hunk** | Discard current change |
| `<leader>hp` | **Preview Hunk** | Show change in popup |
| `<leader>hb` | **Blame Line** | Show git blame |
| `<leader>hd` | **Diff This** | Show diff against index |

---

## ✨ **Prettier Auto-Formatting for JS/TS**

### **Auto-Format on Save**
JavaScript/TypeScript files are now automatically formatted with Prettier when you save:

**Supported File Types:**
- `.js` - JavaScript
- `.ts` - TypeScript
- `.jsx` - React JavaScript
- `.tsx` - React TypeScript
- `.css` - CSS files
- `.html` - HTML files
- `.json` - JSON files

### **Prettier Configuration:**
- ✅ **2 spaces** for indentation
- ✅ **Single quotes** for strings
- ✅ **Semicolons** enabled
- ✅ **Trailing commas** for ES5
- ✅ **100 character** line width

### **Manual Formatting Commands**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>f` | **Format** | Format current file with LSP/Prettier |
| `<leader>mp` | **Prettier Format** | Force Prettier formatting |

### **Format Settings:**
```javascript
// Example: Your JS/TS code will be auto-formatted like this
const myFunction = (param1, param2) => {
  return {
    data: param1,
    result: param2,
  };
};
```

---

## 🌊 **Complete Git Workflows**

### **1. Daily Development Workflow**
```
1. <leader>lg → Open LazyGit
2. See current status and changes
3. Stage files in LazyGit (Space key)
4. Commit with message (c key)
5. Push changes (P key)
```

### **2. Conflict Resolution Workflow**
```
1. Pull/merge triggers conflicts
2. <leader>gdo → Open DiffView to see conflicts
3. <leader>gcl → List all conflicts
4. Navigate with <leader>gcn/<leader>gcp
5. Resolve each conflict with <leader>gco/gct/gcb
6. Save files and commit resolution
```

### **3. Code Review Workflow**
```
1. <leader>gdh → View file history
2. Navigate through commits
3. <leader>gdf → See current file changes
4. Use DiffView to compare versions
5. <leader>hb → Check blame for specific lines
```

### **4. Branch Management Workflow**
```
1. <leader>lg → Open LazyGit
2. 'b' → Branch operations
3. Create/switch branches visually
4. See branch tree and relationships
5. Merge/rebase as needed
```

---

## 🔧 **Installation Status**

### ✅ **Successfully Installed:**
- **LazyGit Plugin** - Git visual interface
- **Git-Conflict Plugin** - Conflict resolution
- **DiffView Plugin** - Advanced diff viewing
- **Prettier** - JavaScript/TypeScript formatting
- **StyLua** - Lua code formatting

### ⚠️ **Notes:**
- **Python Black**: Available via pip3 (system install)
- **LazyGit Binary**: Requires `lazygit` command (install separately if needed)

### **Install LazyGit Binary (Optional):**
```bash
# Ubuntu/Debian
sudo apt install lazygit

# Or download from GitHub releases
wget https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_*_Linux_x86_64.tar.gz
```

---

## 💡 **Pro Tips**

### **Git Efficiency:**
- Use `<leader>lg` as your primary git interface
- Set up git aliases for common operations
- Use DiffView for complex merge conflicts
- Take advantage of auto-formatting for cleaner commits

### **Conflict Resolution:**
- Always use `<leader>gcl` first to see all conflicts
- Resolve conflicts in logical order (dependencies first)
- Test your code after resolving conflicts
- Use `<leader>gco` for simple conflicts (keep your changes)

### **Code Formatting:**
- JS/TS files auto-format on save (no action needed!)
- Use `<leader>f` for manual formatting other file types
- Configure Prettier settings in `.prettierrc` if needed
- Format before committing for cleaner git history

---

*🎉 Your Git workflow is now supercharged with visual interfaces and automatic formatting!*