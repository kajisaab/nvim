# 💾 Buffer & Save Management Guide

## 🎨 Visual Indicators for Unsaved Files

After these changes, you'll have **MULTIPLE** visual indicators showing which files are unsaved:

### 1. **Bufferline (Top of Screen)**
- Shows all open files in tabs at the top
- **Orange dot (●)** appears next to modified files
- **Color highlighting** for active buffer
- **Icons** show file type

**Example:**
```
 file1.js ●  |  file2.ts  |  file3.py ●  |  file4.java
   ↑                           ↑
   Modified               Modified
```

### 2. **Statusline (Bottom - Lualine)**
- Shows current file path with **[●] indicator** for modified files
- **Orange/yellow color** when file is modified
- Shows **[New]** for new unsaved files
- Shows **[🔒]** for readonly files

**Example:**
```
NORMAL | main | + 3 ~ 2 - 1 | src/utils/helper.js [●]  |  TypeScript |
                                                  ↑
                                           Modified indicator
```

### 3. **Window Title**
- Your terminal/window title shows: `filename [+]`
- The `[+]` appears when file is modified

### 4. **Warning on Quit**
- If you try to quit with unsaved files, you get a popup:
  ```
  You have unsaved changes in 2 file(s)!
  Do you want to save them?
  [Yes] [No] [Cancel]
  ```

---

## ⌨️ Keyboard Shortcuts

### Save Files

| Shortcut | Action | Mode |
|----------|--------|------|
| `Ctrl+S` | **Quick save** (like VSCode) | Normal & Insert |
| `Space w` | Save current file | Normal |
| `Space W` | **Save ALL files** | Normal |

### Navigate Between Buffers (Open Files)

| Shortcut | Action |
|----------|--------|
| `Tab` | Next buffer (file) |
| `Shift+Tab` | Previous buffer |
| `Shift+L` | Next buffer (alternative) |
| `Shift+H` | Previous buffer (alternative) |
| `Space bb` | Show all buffers (Telescope picker) |
| `Space bp` | Pick buffer (interactive) |

### Close Buffers

| Shortcut | Action |
|----------|--------|
| `Space x` | Close current buffer |
| `Space X` | Close all OTHER buffers (keep current) |

### Buffer Management

| Shortcut | Action |
|----------|--------|
| `Space bP` | Pin/unpin buffer (keeps it visible) |
| `Space bs` | Sort buffers by directory |

---

## 🚀 Quick Usage Examples

### Scenario 1: Working with Multiple Files

1. **Open files:**
   ```vim
   :e file1.js
   :e file2.ts
   :e file3.py
   ```

2. **See all open files** at the top in bufferline

3. **Switch between them:**
   - Press `Tab` to go to next file
   - Press `Shift+Tab` to go to previous file
   - Or press `Space bb` to see all and pick one

4. **Save all at once:**
   - Press `Space W` (capital W) to save all files

### Scenario 2: Identifying Unsaved Files

**Visual Check:**
- Look at the **top bar** (bufferline) → files with **●** are unsaved
- Look at **bottom left** (statusline) → **[●]** means current file is unsaved
- Look at **window title** → **[+]** means file is modified

**Quick Save:**
- Press `Ctrl+S` to save current file
- Press `Space W` to save ALL files

### Scenario 3: Closing Neovim with Unsaved Files

1. Type `:q` or `:qa`
2. **Popup appears:** "You have unsaved changes in X file(s)!"
3. Choose:
   - **Yes** → Saves all files and quits
   - **No** → Quits without saving (loses changes)
   - **Cancel** → Cancels quit, stays in Neovim

---

## 🎯 Tips & Tricks

### 1. **Pin Important Files**
Press `Space bP` to pin a buffer. Pinned buffers stay visible even when you have many files open.

### 2. **Quick Save Habit**
Get used to `Ctrl+S` - it works in both normal and insert mode!

### 3. **Save All Before Running Tests**
Before running tests or builds, press `Space W` to save everything at once.

### 4. **Buffer Picker**
Press `Space bp` for an interactive buffer picker - type a letter to jump to that buffer instantly!

### 5. **See All Files**
Press `Space bb` to see all open files in Telescope - you can search and filter them.

---

## 📊 Bufferline Features

### Visual Elements:

```
┌─────────────────────────────────────────────────────────────┐
│  file1.js ●  │  file2.ts  │  file3.py ●  │   │          │
│      ↑            ↑             ↑          ↑      ↑       │
│   Modified    Current      Modified    Close   Errors    │
│   (orange)   (bright)      (orange)    icon   indicator  │
└─────────────────────────────────────────────────────────────┘
```

### Features:
- **Modified indicator (●)** in orange/yellow
- **LSP diagnostics** shown (errors/warnings count)
- **Close button** on hover
- **File icons** for each file type
- **Separators** between buffers (slant style)
- **NvimTree offset** - bufferline adjusts when file tree is open

---

## 🔧 Configuration Files Modified

1. **`lua/sethy/plugins/lualine.lua`** - Enhanced statusline with better modified indicators
2. **`lua/sethy/plugins/bufferline.lua`** - NEW! Top buffer/tab bar with visual indicators
3. **`lua/sethy/core/keymaps.lua`** - Added save shortcuts and buffer navigation
4. **`lua/sethy/core/options.lua`** - Window title shows modified status

---

## 🐛 Troubleshooting

### Bufferline not showing?

Restart Neovim - Lazy.nvim will automatically install the plugin:
```bash
nvim
```

### Shortcuts not working?

Make sure bufferline is loaded:
```vim
:Lazy
" Look for 'bufferline.nvim' - should show checkmark
```

### Modified indicator not showing?

1. Make a change to the file
2. Look at the top bar - should see **●** next to filename
3. Look at bottom left - should see **[●]** in statusline
4. If still not showing, try `:LualineRefresh`

---

## 🎨 Color Customization

The modified indicator uses **orange/yellow (#ff9e64)** by default.

To change it, edit:
- `lua/sethy/plugins/bufferline.lua` → search for `#ff9e64`
- `lua/sethy/plugins/lualine.lua` → search for `#ff9e64`

---

## 📚 Learn More

- `:help bufferline` - Bufferline documentation
- `:help lualine` - Lualine documentation
- `Space ?` - Open your shortcuts cheatsheet

---

## ✨ Summary

You now have **4 ways** to see unsaved files:
1. **Bufferline** (top) - Orange dot ●
2. **Statusline** (bottom) - [●] indicator
3. **Window title** - [+] flag
4. **Quit warning** - Popup dialog

You have **multiple ways** to save:
- `Ctrl+S` - Quick save (VSCode style)
- `Space w` - Save current
- `Space W` - Save all

You can easily **navigate buffers**:
- `Tab` / `Shift+Tab` - Navigate
- `Space bb` - List all
- `Space bp` - Pick one

**No more confusion about saved/unsaved files!** 🎉
