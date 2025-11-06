# 🚀 Setup Guide: AI Assistant & Real-Time Diagnostics

## ⚠️ Issues Found

### 1. Node.js Not Available in WSL
**Problem:** Node.js is installed on Windows but not accessible in WSL as `node` command.
**Impact:** ESLint diagnostics won't work (requires Node.js)

### 2. AI Assistant Added
**New:** Avante.nvim plugin installed - supports Claude & Gemini!

---

## 🔧 STEP 1: Fix Node.js for Diagnostics (REQUIRED)

### Option A: Install Node.js in WSL (Recommended)

```bash
# Install Node.js using nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Restart terminal or run (you're using zsh):
source ~/.zshrc

# Install Node.js LTS
nvm install --lts

# Verify installation
node --version
npm --version
```

### Option B: Create Symlink to Windows Node (Quick Fix)

```bash
# Create symlinks to Windows Node.js
sudo ln -s /mnt/c/nvm4w/nodejs/node.exe /usr/local/bin/node
sudo ln -s /mnt/c/nvm4w/nodejs/npm /usr/local/bin/npm

# Verify
node --version
```

**After fixing Node.js, restart Neovim and diagnostics will work!**

---

## 🤖 STEP 2: Configure AI Assistant (Avante.nvim)

### What is Avante?
- AI coding assistant similar to Cursor/Claude
- Chat with AI about your code
- Generate code, explain code, fix bugs
- Supports Claude API & Gemini

### Setup API Keys

#### For Claude (Anthropic):

```bash
# Add to your ~/.zshrc (you're using zsh)
export ANTHROPIC_API_KEY="your-api-key-here"

# Reload shell
source ~/.zshrc
```

Get your API key from: https://console.anthropic.com/

#### For Gemini (Google):

```bash
# Add to your ~/.zshrc (you're using zsh)
export GEMINI_API_KEY="your-api-key-here"

# Reload shell
source ~/.zshrc
```

Get your API key from: https://aistudio.google.com/app/apikey

### Switch Between Providers

Edit `/home/kajisaab/.config/nvim/lua/sethy/plugins/avante.lua`:

```lua
provider = "claude",  -- Change to "gemini" to use Gemini
```

**Note:** The configuration now uses the new `providers` format for better organization.

---

## 🎯 STEP 3: Using Avante (AI Assistant)

### Keybindings:

| Mode | Key | Action |
|------|-----|--------|
| Normal/Visual | `<leader>aa` | Open Avante chat |
| Normal/Visual | `<leader>ar` | Refresh/retry |
| Normal/Visual | `<leader>ae` | Edit selection |
| Chat | `<CR>` | Submit message |
| Chat | `<C-s>` | Submit (insert mode) |
| Suggestions | `<M-l>` | Accept suggestion |
| Suggestions | `<M-]>` | Next suggestion |
| Suggestions | `<M-[>` | Previous suggestion |

### Workflow Example:

1. **Open a file with code**
2. **Select code in visual mode** (press `V`)
3. **Press `<leader>aa`** (Space + aa)
4. **Type your question:**
   - "Explain this function"
   - "Add error handling"
   - "Refactor this code"
   - "Add TypeScript types"
   - "Fix bugs in this code"
5. **Press Enter** to submit
6. **AI responds** with explanation or code changes
7. **Press `a`** to apply changes at cursor
8. **Press `A`** to apply all changes

---

## 📊 STEP 4: Verify Everything Works

### Test Diagnostics:

1. Open Neovim
2. Create a test file:
```bash
nvim test.ts
```

3. Type some code with errors:
```typescript
const x: string = 123;  // Should show type error
consle.log("test");     // Should show ESLint error
```

4. **You should see:**
   - Red underlines
   - Error messages inline
   - Gutter icons (  )

### Test AI Assistant:

1. Open a file with code
2. Press `<leader>aa` (Space + aa)
3. Type: "Hello, can you help me?"
4. Press Enter
5. AI should respond!

---

## 🐛 Troubleshooting

### Diagnostics Not Showing:

```vim
" In Neovim, run:
:LspInfo          " Check if LSP is attached
:Mason            " Check if tools are installed
:messages         " Check for errors
```

### AI Not Working:

1. Check API key is set:
```bash
echo $ANTHROPIC_API_KEY  # or $GEMINI_API_KEY
```

2. Check Avante is loaded:
```vim
:Lazy             " Check if avante.nvim is installed
```

3. Build Avante (if needed):
```vim
:Lazy build avante.nvim
```

### ESLint Errors:

If you see "eslint configuration not found":
```bash
# In your project directory
npm init -y
npm install --save-dev eslint
npx eslint --init
```

---

## 📝 Summary of Changes

### Files Modified:
1. `/home/kajisaab/.config/nvim/lua/sethy/plugins/lsp/lspconfig.lua`
   - Enabled `update_in_insert = true` for real-time diagnostics

2. `/home/kajisaab/.config/nvim/lua/sethy/plugins/linting.lua`
   - Added `TextChanged` and `TextChangedI` events for real-time linting

### Files Created:
1. `/home/kajisaab/.config/nvim/lua/sethy/plugins/avante.lua`
   - AI assistant plugin configuration

---

## 🎉 Next Steps

1. **Fix Node.js** (Step 1) - REQUIRED for diagnostics
2. **Set API key** (Step 2) - REQUIRED for AI
3. **Restart Neovim**
4. **Test diagnostics** (Step 4)
5. **Try AI assistant** (Step 3)

---

## 💡 Tips

- Use `<leader>lx` to toggle diagnostics on/off
- Use `<leader>d` to show diagnostic details
- Use `<leader>l` to manually trigger linting
- Avante sidebar appears on the right side
- You can chat with AI about any code in your project!

---

Need help? Check `:help avante` or open an issue!
