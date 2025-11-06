# Neovim Troubleshooting Guide

## 🚀 Current Status

### ✅ **Successfully Updated & Working:**
- **Neovim**: v0.11.5 (Latest stable)
- **Core plugins**: All updated and functional
- **LSP Configuration**: Updated to new v0.11 API
- **Go Language Server**: gopls installed and working
- **JavaScript/TypeScript**: ts_ls working
- **Lua Language Server**: lua_ls working
- **Java Support**: JDTLS working

### ⚠️ **Known Issues & Solutions:**

#### Python Tools (isort, pylint)
**Issue**: Mason fails to install Python tools due to missing `python3-venv`

**Error Message**:
```
The virtual environment was not created successfully because ensurepip is not available.
On Debian/Ubuntu systems, you need to install the python3.10-venv package
```

**Solutions**:
1. **System-wide install (Recommended)**:
   ```bash
   sudo apt install python3.10-venv
   # Then in nvim: :MasonInstall isort pylint
   ```

2. **User-level install (Alternative)**:
   ```bash
   pip3 install --user isort pylint
   # Tools available at ~/.local/bin/isort and ~/.local/bin/pylint
   ```

3. **Use without Mason**:
   - Python tools are already installed via pip3
   - Add to PATH: `export PATH="$HOME/.local/bin:$PATH"`

## 🔧 **Dependency Requirements**

### Essential Dependencies (Installed ✅)
- **Node.js**: v20.19.4 (for JavaScript/TypeScript LSP)
- **Go**: v1.21.5 → Auto-upgraded to v1.24.9 (for gopls)
- **Python3**: Available (for Python LSP)

### Language Server Status
| Language | Server | Status | Notes |
|----------|--------|--------|-------|
| Lua | lua_ls | ✅ Working | Built-in Neovim support |
| JavaScript/TypeScript | ts_ls | ✅ Working | Node.js required |
| Go | gopls | ✅ Working | Installed via Mason |
| Java | JDTLS | ✅ Working | Eclipse JDT Language Server |
| Python | pylsp | ⚠️ Partial | Manual install needed |
| HTML/CSS | emmet_ls | ✅ Working | Emmet expansion |

## 🏥 **Health Check Commands**

### Check Neovim Health
```bash
~/bin/nvim --headless +"checkhealth" +qa
```

### Check LSP Status
```bash
~/bin/nvim --headless +":LspInfo" +qa
```

### Check Mason Status
```bash
~/bin/nvim --headless +":Mason" +qa
```

### Check PATH Configuration
```bash
echo $PATH | tr ':' '\n' | grep -E "(go|local)"
which go python3 node npm
```

## 🐛 **Common Issues & Fixes**

### 1. **LSP Not Working**
**Symptoms**: No autocompletion, go-to-definition not working
**Solutions**:
- Check `:LspInfo` in nvim
- Ensure language servers are installed: `:Mason`
- Restart LSP: `<leader>rs`

### 2. **Mason Installation Failures**
**Symptoms**: Error messages when installing language servers
**Solutions**:
- Check internet connection
- Ensure dependencies are installed (go, python3, node)
- Try manual installation
- Check `:MasonLog` for detailed errors

### 3. **Keybindings Not Working**
**Symptoms**: Shortcuts don't respond
**Solutions**:
- Check if plugins are loaded: `:Lazy`
- Use which-key: Press `<Space>` and wait
- Check keybinding docs: See `NVIM_ESSENTIAL_SHORTCUTS.md`

### 4. **Plugin Load Errors**
**Symptoms**: Error messages on startup
**Solutions**:
- Update plugins: `:Lazy sync`
- Check configuration: `:checkhealth lazy`
- Review error logs

### 5. **Terminal Integration Issues**
**Symptoms**: `<Alt-i>` doesn't open terminal
**Solutions**:
- Check terminal emulator Alt key support
- Try `<A-i>` or configure alternative keybinding
- Test in different terminal applications

## 📋 **Installation Commands Summary**

### Re-install Missing Components
```bash
# Go (if needed)
wget -O go.tar.gz https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
tar -C ~ -xzf go.tar.gz
echo 'export PATH=$HOME/go/bin:$PATH' >> ~/.zshrc

# Python tools
pip3 install --user isort pylint

# Update PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Install language servers in nvim
~/bin/nvim --headless +"MasonInstall gopls lua_ls ts_ls" +qa
```

## 📖 **Getting Help**

### Documentation Priority Order
1. **Quick Start**: `QUICK_REFERENCE_CARD.md` (print this!)
2. **Daily Use**: `NVIM_ESSENTIAL_SHORTCUTS.md`
3. **Advanced**: `NVIM_ADVANCED_NAVIGATION.md`
4. **Complete Reference**: `NVIM_KEYBINDINGS.md`
5. **Plugin Details**: `NVIM_PLUGINS.md`

### In-Editor Help
- Press `<Space>` and wait → See available commands
- `:help {topic}` → Built-in help
- `K` on any function → Show documentation
- `:LspInfo` → Check language server status
- `:Mason` → Manage language servers

### External Resources
- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim Wiki](https://github.com/folke/lazy.nvim)
- [Mason.nvim Packages](https://mason-registry.dev/registry/list)

---

*Last updated: November 2025 - All core functionality working, Python tools require system dependency*