# Neovim Keymaps Reference

Complete reference of all custom keymaps in this Neovim configuration.

**Leader Key:** `Space`

---

## Table of Contents

- [Core Keymaps](#core-keymaps)
  - [Visual Mode](#visual-mode)
  - [Navigation](#navigation)
  - [Delete & Paste](#delete--paste)
  - [Find & Replace](#find--replace)
  - [File Operations](#file-operations)
  - [LSP](#lsp)
  - [Buffer Management](#buffer-management)
  - [Tab Management](#tab-management)
  - [Split Management](#split-management)
- [Terminal](#terminal)
- [Neovide GUI](#neovide-gui)
- [Plugin Keymaps](#plugin-keymaps)
  - [Undotree](#undotree)
  - [TypeScript Tools](#typescript-tools)
  - [Todo Comments](#todo-comments)
  - [Telescope (Fuzzy Finder)](#telescope-fuzzy-finder)
  - [UFO (Folding)](#ufo-folding)
  - [Nvim Tree (File Explorer)](#nvim-tree-file-explorer)
  - [Mini.nvim](#minvim)
  - [LSP Config](#lsp-config)
  - [Linting](#linting)
  - [Java (JDTLS)](#java-jdtls)
  - [Harpoon](#harpoon)
  - [Git Worktree](#git-worktree)
  - [Git Integration](#git-integration)
  - [Git Conflict](#git-conflict)
  - [Formatting (Conform)](#formatting-conform)
  - [Emmet](#emmet)
  - [Diffview](#diffview)
  - [Debugging (DAP)](#debugging-dap)
  - [Markdown](#markdown)
  - [Multi-Cursor](#multi-cursor)

---

## Core Keymaps

### Visual Mode

| Keys | Mode | Description |
|------|------|-------------|
| `J` | v | Moves lines down in visual selection |
| `K` | v | Moves lines up in visual selection |
| `<` | v | Decrease indent (stays in visual mode) |
| `>` | v | Increase indent (stays in visual mode) |
| `<leader>p` | x | Paste without yanking (preserves clipboard) |
| `p` | v | Paste without yanking |
| `<leader>s` | v | Replace word in selection |

### Navigation

| Keys | Mode | Description |
|------|------|-------------|
| `J` | n | Join lines |
| `Ctrl+d` | n | Jump 10 lines down |
| `Ctrl+u` | n | Jump 10 lines up |
| `Ctrl+j` | n | Half page down with cursor centered |
| `Ctrl+k` | n | Half page up with cursor centered |
| `n` | n | Next search result (centered) |
| `N` | n | Previous search result (centered) |

### Delete & Paste

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>Y` | n | Yank line to system clipboard |
| `<leader>dd` | n,v | Delete without yanking |
| `jk` | i | Escape from insert mode |
| `x` | n | Delete character without yanking |

### Comments

| Keys | Mode | Description |
|------|------|-------------|
| `Ctrl+/` | n | Toggle comment (current line) |
| `Ctrl+/` | v | Toggle comment (selection) |
| `Ctrl+/` | i | Toggle comment (from insert mode) |
| `gc` | n,v | Toggle comment (default mini.comment) |
| `gcc` | n | Toggle comment line (default mini.comment) |

### Find & Replace

| Keys | Mode | Description |
|------|------|-------------|
| `Ctrl+c` | n | Clear search highlighting |
| `<leader>s` | n | Replace word cursor is on globally |
| `<leader>sr` | n | Replace word with confirmation |

### File Operations

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>f` | n | Format file using LSP |
| `<leader>xx` | n | Make file executable |
| `<leader>fp` | n | Copy file path to clipboard |
| `<leader>?` | n | Open shortcuts cheatsheet |

### LSP

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>lx` | n | Toggle LSP diagnostics visibility |
| `<leader>li` | n | LSP: Organize Imports |

### Buffer Management

| Keys | Mode | Description |
|------|------|-------------|
| `Ctrl+s` | n | Save file |
| `Ctrl+s` | i | Save file (from insert mode) |
| `<leader>w` | n | Save file |
| `<leader>W` | n | Save ALL files |
| `Shift+l` | n | Next buffer |
| `Shift+h` | n | Previous buffer |
| `Tab` | n | Next buffer |
| `Shift+Tab` | n | Previous buffer |
| `<leader>x` | n | Close current buffer |
| `<leader>X` | n | Close all other buffers |
| `<leader>bp` | n | Pick buffer |
| `<leader>bb` | n | List all buffers |
| `<leader>bP` | n | Pin/Unpin buffer |
| `<leader>bs` | n | Sort buffers by directory |

### Tab Management

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>to` | n | Open new tab |
| `<leader>tx` | n | Close current tab |
| `<leader>tn` | n | Go to next tab |
| `<leader>tp` | n | Go to previous tab |
| `<leader>tf` | n | Open current file in new tab |

### Split Management

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>sv` | n | Split window vertically |
| `<leader>sh` | n | Split window horizontally |
| `<leader>se` | n | Make splits equal size |
| `<leader>sx` | n | Close current split |

---

## Terminal

| Keys | Mode | Description |
|------|------|-------------|
| `Esc Esc` | t | Exit terminal mode |
| `Ctrl+v` | t | Exit to select text (for copying) |
| `y` | v | Yank to system clipboard (in terminal) |
| `Ctrl+b` | n,t | Toggle tmux floating terminal |
| `Ctrl+w s` | t | Split terminal horizontally |
| `Ctrl+w v` | t | Split terminal vertically |
| `Ctrl+w h` | t | Move to left window |
| `Ctrl+w j` | t | Move to down window |
| `Ctrl+w k` | t | Move to up window |
| `Ctrl+w l` | t | Move to right window |
| `Ctrl+w q` | t | Close terminal split |

---

## Neovide GUI

| Keys | Mode | Description |
|------|------|-------------|
| `Cmd+=` | n | Zoom in (increase scale) |
| `Cmd+-` | n | Zoom out (decrease scale) |

---

## Plugin Keymaps

### Undotree

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>u` | n | Toggle undo tree |

### TypeScript Tools

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>cm` | n | Implement interface members |
| `<leader>cA` | n | Add all missing imports |

### Todo Comments

| Keys | Mode | Description |
|------|------|-------------|
| `]t` | n | Next todo comment |
| `[t` | n | Previous todo comment |

### Telescope (Fuzzy Finder)

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>ff` | n | Find Files |
| `<leader>fg` | n | Live Grep (search in files) |
| `<leader>fb` | n | Find Buffers |
| `<leader>fr` | n | Recent Files |
| `<leader>fw` | n | Find Word under cursor |
| `<leader>fc` | n | Find Commands |
| `<leader>fh` | n | Find Help |
| `Ctrl+f` | n | Global Search (like VSCode) |

**Telescope Insert Mode:**

| Keys | Mode | Description |
|------|------|-------------|
| `Ctrl+k` | i | Move selection previous |
| `Ctrl+j` | i | Move selection next |

### UFO (Folding)

| Keys | Mode | Description |
|------|------|-------------|
| `zR` | n | Open all folds |
| `zM` | n | Close all folds |

### Nvim Tree (File Explorer)

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>ee` | n | Toggle file explorer |
| `<leader>ef` | n | Find current file in explorer |
| `<leader>ec` | n | Collapse all folders |
| `<leader>er` | n | Refresh file explorer |

### Mini.nvim

**Mini Trailspace:**

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>cw` | n | Erase trailing whitespace |

**Mini Splitjoin:**

| Keys | Mode | Description |
|------|------|-------------|
| `sj` | n,x | Join arguments |
| `sk` | n,x | Split arguments |

### LSP Config

| Keys | Mode | Description |
|------|------|-------------|
| `gr` | n | Show LSP references |
| `gD` | n | Go to declaration |
| `gd` | n | Show LSP definitions |
| `gI` | n | Show LSP implementations |
| `gy` | n | Show LSP type definitions |
| `<leader>vca` | n,v | See available code actions |
| `<leader>cf` | n | Quick fix (implement interface/fix error) |
| `<leader>cm` | n | Implement all interface methods |
| `<leader>rn` | n | Smart rename |
| `<leader>D` | n | Show buffer diagnostics |
| `<leader>d` | n | Show line diagnostics |
| `K` | n | Show documentation for what is under cursor |
| `<leader>rs` | n | Restart LSP |
| `<leader>ca` | n | Add missing imports |
| `<leader>co` | n | Organize imports |
| `<leader>cr` | n | Remove unused imports |
| `Ctrl+h` | i | Show signature help |

### Linting

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>l` | n | Trigger linting for current file |

### Java (JDTLS)

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>cm` | n | Implement interface/abstract methods |
| `<leader>cg` | n | Generate getters/setters |
| `<leader>cc` | n | Generate constructor |

### Harpoon

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>a` | n | Harpoon add file |
| `Ctrl+e` | n | Toggle Harpoon quick menu |
| `Ctrl+y` | n | Select harpoon file 1 |
| `Ctrl+i` | n | Select harpoon file 2 |
| `Ctrl+n` | n | Select harpoon file 3 |
| `Ctrl+s` | n | Select harpoon file 4 |
| `Ctrl+Shift+P` | n | Previous harpoon file |
| `Ctrl+Shift+N` | n | Next harpoon file |

### Git Worktree

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>wl` | n | List Git Worktree |
| `<leader>wc` | n | Create Git Worktree Branches |

### Git Integration

**Fugitive:**

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>gg` | n | Open git status |
| `<leader>P` | n | Git push |
| `<leader>p` | n | Git pull with rebase |
| `<leader>t` | n | Set upstream branch |

**Gitsigns:**

| Keys | Mode | Description |
|------|------|-------------|
| `]h` | n | Next Hunk |
| `[h` | n | Previous Hunk |
| `<leader>gs` | n | Stage hunk |
| `<leader>gr` | n | Reset hunk |
| `<leader>gs` | v | Stage selected hunk |
| `<leader>gr` | v | Reset selected hunk |
| `<leader>gS` | n | Stage whole buffer |
| `<leader>gR` | n | Reset buffer |
| `<leader>gu` | n | Undo stage hunk |
| `<leader>gp` | n | Preview hunk |
| `<leader>gbl` | n | Blame line |
| `<leader>gB` | n | Toggle line blame |
| `<leader>gh` | n | Diff this (git) |
| `<leader>gH` | n | Diff this ~ (git) |
| `ih` | o,x | Gitsigns select hunk |

### Git Conflict

**Quick Conflict Resolution:**

| Keys | Mode | Description |
|------|------|-------------|
| `co` | n | Choose Ours (Current Branch) |
| `ct` | n | Choose Theirs (Incoming Branch) |
| `cb` | n | Choose Both |
| `c0` | n | Choose None |
| `]x` | n | Next Conflict |
| `[x` | n | Previous Conflict |
| `<leader>cl` | n | List All Conflicts |

**Alternative (Leader-based):**

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>gco` | n | Choose Ours (Current Branch) |
| `<leader>gct` | n | Choose Theirs (Incoming Branch) |
| `<leader>gcb` | n | Choose Both |
| `<leader>gc0` | n | Choose None |
| `<leader>gcl` | n | List All Conflicts |

### Formatting (Conform)

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>mp` | n,v | Format file or range with Prettier |

### Emmet

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>xe` | n,v | Wrap with Emmet abbreviation |

### Git History & Timeline

**Quick Access (Like VSCode):**

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>gh` | n | Git File History (Timeline) |
| `<leader>gh` | v | Git Selection History |
| `<leader>gb` | n | Git File Blame/History |
| `<leader>gm` | n | Show commit message at cursor |

**Diffview Commands:**

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>gdo` | n | Open Diffview |
| `<leader>gdc` | n | Close Diffview |
| `<leader>gdh` | n | All File History |
| `<leader>gdf` | n | Current File History |
| `<leader>gdr` | n | Refresh Diffview |

**Diffview View:**

| Keys | Mode | Description |
|------|------|-------------|
| `Tab` | n | Open diff for next file |
| `Shift+Tab` | n | Open diff for previous file |
| `gf` | n | Open file in previous tabpage |
| `Ctrl+w Ctrl+f` | n | Open file in new split |
| `Ctrl+w gf` | n | Open file in new tabpage |
| `<leader>e` | n | Focus file panel |
| `<leader>b` | n | Toggle file panel |
| `g Ctrl+x` | n | Cycle through layouts |
| `[x` | n | Previous conflict (merge-tool) |
| `]x` | n | Next conflict (merge-tool) |

**Diffview File Panel:**

| Keys | Mode | Description |
|------|------|-------------|
| `j` / `Down` | n | Next file entry |
| `k` / `Up` | n | Previous file entry |
| `Enter` / `o` | n | Open diff for selected entry |
| `-` | n | Stage / unstage entry |
| `S` | n | Stage all entries |
| `U` | n | Unstage all entries |
| `X` | n | Restore entry to left side |
| `L` | n | Open commit log panel |
| `Ctrl+b` | n | Scroll view up |
| `Ctrl+f` | n | Scroll view down |
| `i` | n | Toggle between list/tree views |
| `f` | n | Toggle flatten dirs |
| `R` | n | Refresh files |

**Diffview Conflict Resolution:**

| Keys | Mode | Description |
|------|------|-------------|
| `2do` | n,x | Choose OURS version (3-way) |
| `3do` | n,x | Choose THEIRS version (3-way) |
| `1do` | n,x | Choose BASE version (4-way) |

### Debugging (DAP)

**Core Debugging:**

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>db` | n | Toggle breakpoint |
| `<leader>dc` | n | Continue/Start debugging |
| `<leader>dso` | n | Step over |
| `<leader>dsi` | n | Step into |
| `<leader>dsx` | n | Step out |
| `<leader>dr` | n | Open REPL |
| `<leader>dl` | n | Run last configuration |
| `<leader>dt` | n | Toggle DAP UI |

**Language-Specific Run/Build:**

**C/C++:**
| Keys | Mode | Description |
|------|------|-------------|
| `<leader>cc` | n | Compile and run |
| `<leader>cb` | n | Compile only |

**Go:**
| Keys | Mode | Description |
|------|------|-------------|
| `<leader>gr` | n | Run Go file |
| `<leader>gb` | n | Build Go project |
| `<leader>gt` | n | Run Go tests |

**Rust:**
| Keys | Mode | Description |
|------|------|-------------|
| `<leader>rr` | n | Cargo run |
| `<leader>rb` | n | Cargo build |
| `<leader>rt` | n | Cargo test |
| `<leader>rc` | n | Cargo check |
| `<leader>rcl` | n | Cargo clippy |

### Markdown

**List Toggle (Normal Mode):**

| Keys | Mode | Description |
|------|------|-------------|
| `tn` | n | Toggle numbers on current line |
| `tb` | n | Toggle bullets on current line |
| `tc` | n | Toggle checkboxes on current line |
| `tt` | n | Toggle task state on current line |
| `tl` | n | Smart list toggle on current line |

**List Toggle (Visual Mode):**

| Keys | Mode | Description |
|------|------|-------------|
| `tn` | v | Toggle numbers on selected lines |
| `tb` | v | Toggle bullets on selected lines |
| `tc` | v | Toggle checkboxes on selected lines |
| `tt` | v | Toggle task state on selected lines |
| `tl` | v | Smart list toggle on selected lines |

**Task Management:**

| Keys | Mode | Description |
|------|------|-------------|
| `<leader>tc` | n | Mark all tasks done |
| `<leader>tu` | n | Mark all tasks undone |

### Multi-Cursor

| Keys | Mode | Description |
|------|------|-------------|
| `Cmd+d` | n | Find and select next occurrence |
| `Ctrl+x` | n | Skip current and find next |
| `<leader>A` | n | Select all occurrences |
| `Alt+Down` | n | Add cursor below |
| `Alt+Up` | n | Add cursor above |
| `<leader>v` | v | Visual Multi cursor mode |
| `u` | multi | Undo cursors |
| `Ctrl+r` | multi | Redo cursors |
| `Tab` | multi | Switch mode |

---

## Misc Settings

**Leader Key:** `Space`

**Escape Alternatives:**
- `jk` in insert mode
- `Ctrl+c` clears search highlighting

**Auto-save:**
- Modified buffers warning on quit

**Clipboard:**
- Uses system clipboard by default

---

## Language Support

Your Neovim is configured with full LSP, formatting, linting, and debugging support for:

- **C/C++**: clangd LSP, clang-format, cpplint, codelldb debugger
- **Python**: pyright LSP, ruff formatter, pylint linter, debugpy debugger
- **Go**: gopls LSP, gofumpt + goimports formatters, golangci-lint, delve debugger
- **Rust**: rust-analyzer LSP, rustfmt, clippy, codelldb debugger
- **TypeScript/JavaScript**: typescript-tools, prettier, eslint_d
- **Java**: jdtls LSP with full support
- **Lua**: lua_ls LSP, stylua formatter

All formatters run automatically on save!

---

## Quick Tips

**Terminal Copy/Paste:**
1. Press `Ctrl+v` in terminal mode to exit to normal mode
2. Enter visual mode with `v` and select text
3. Press `y` to copy to system clipboard
4. Paste anywhere with `Cmd+v` (macOS) or `Ctrl+v` (Linux/Windows)

**Merge Conflict Resolution:**
1. When you see conflicts, use `]x` to jump to next conflict
2. Use `co` (ours), `ct` (theirs), `cb` (both), or `c0` (none)
3. Save and continue!

**View File History (Like VSCode Timeline):**
1. Press `<leader>gh` to see file history
2. Navigate with `j`/`k`, press `Enter` to see changes
3. Press `q` to close

---

*This document was auto-generated from the Neovim configuration files.*
*Last updated: 2025-11-27*
