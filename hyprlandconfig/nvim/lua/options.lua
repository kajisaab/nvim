require "nvchad.options"

-- add yours here!

local o = vim.o
local opt = vim.opt

o.cursorlineopt = "both" -- to enable cursorline!
opt.relativenumber = true

-- ========================================
-- LEGACY OPTIONS INTEGRATION
-- ========================================

-- Configure NVM Node.js path for Neovim
local nvm_dir = vim.fn.expand("$HOME/.nvm/versions/node")
if vim.fn.isdirectory(nvm_dir) == 1 then
  local versions = vim.fn.globpath(nvm_dir, "v*", false, true)
  if #versions > 0 then
    table.sort(versions)
    local latest_version = versions[#versions]
    local nvm_node_path = latest_version .. "/bin"
    if vim.fn.isdirectory(nvm_node_path) == 1 then
      vim.env.PATH = nvm_node_path .. ":" .. vim.env.PATH
    end
  end
end

-- Font for GUI
opt.guifont = "Monaspace Radon:h10"

-- Tab settings (4 spaces)
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Line wrapping enabled for full screen width
opt.wrap = true
opt.linebreak = true -- Break lines at word boundaries

-- Undo configuration
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- Search settings
opt.incsearch = true
opt.inccommand = "split"
opt.ignorecase = true
opt.smartcase = true

-- Scrolling
opt.scrolloff = 8
opt.signcolumn = "yes"

-- Folding (for nvim-ufo)
o.foldenable = true
o.foldmethod = "manual"
o.foldlevel = 99
o.foldcolumn = "0"

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Update time
opt.updatetime = 50

-- Color column at 80 chars (disabled - remove vertical line)
-- opt.colorcolumn = "80"

-- Clipboard (use system clipboard)
opt.clipboard:append("unnamedplus")

-- Mouse
opt.mouse = "a"

-- Window title
opt.title = true
opt.titlestring = "%t %M"

-- Backspace behavior
opt.backspace = { "start", "eol", "indent" }

-- EditorConfig support
vim.g.editorconfig = true
