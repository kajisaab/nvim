require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- disable NvChad terminal keymaps
vim.keymap.del("n", "<leader>h")
vim.keymap.del("n", "<leader>v")
map({ "n", "t" }, "<A-v>", "<nop>", { desc = "disabled" })
map({ "n", "t" }, "<A-h>", "<nop>", { desc = "disabled" })

-- Save file with Ctrl + S in normal, insert, and visual modes
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Move cursor in insert mode with Alt + h/j/k/l
map("i", "<A-h>", "<Left>", { desc = "Move left in insert mode" })
map("i", "<A-j>", "<Down>", { desc = "Move down in insert mode" })
map("i", "<A-k>", "<Up>", { desc = "Move up in insert mode" })
map("i", "<A-l>", "<Right>", { desc = "Move right in insert mode" })

-- Select all with Ctrl + A
map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("i", "<C-a>", "<ESC>ggVG", { desc = "Select all in insert mode" })
map("v", "<C-a>", "<ESC>ggVG", { desc = "Select all in visual mode" })

-- lazyGit integration
map("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

-- Visual mode block selections
map("v", "<leader>i{", "vi{", { desc = "Select inside {}" })
map("v", "<leader>a{", "va{", { desc = "Select around {}" })

map("v", "<leader>i(", "vi(", { desc = "Select inside ()" })
map("v", "<leader>a(", "va(", { desc = "Select around ()" })

map("v", "<leader>i[", "vi[", { desc = "Select inside []" })
map("v", "<leader>a[", "va[", { desc = "Select around []" })

map("v", '<leader>i"', 'vi"', { desc = 'Select inside ""' })
map("v", '<leader>a"', 'va"', { desc = 'Select around ""' })

map("v", "<leader>i'", "vi'", { desc = "Select inside ''" })
map("v", "<leader>a'", "va'", { desc = "Select around ''" })

map("v", "<leader>i`", "vi`", { desc = "Select inside ``" })
map("v", "<leader>a`", "va`", { desc = "Select around ``" })

-- Move between buffers with g + number keys (normal mode only)
for i = 1, 9 do
  vim.keymap.set("n", "g" .. i, function()
    local bufs = vim.fn.getbufinfo { buflisted = 1 }
    if bufs[i] then
      vim.api.nvim_set_current_buf(bufs[i].bufnr)
    end
  end, { desc = "Switch to listed buffer " .. i })
end
-- g0 switches to the last listed buffer
vim.keymap.set("n", "g0", function()
  local bufs = vim.fn.getbufinfo { buflisted = 1 }
  if bufs[#bufs] then
    vim.api.nvim_set_current_buf(bufs[#bufs].bufnr)
  end
end, { desc = "Switch to last listed buffer" })

-- Toggle terminal with Alt + i in normal and terminal modes with custom floating window options
map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "floatTerm",
    float_opts = {
      row = 0.1,
      col = 0.08,
      width = 0.8,
      height = 0.7,
      border = "rounded",
    },
  }
end, { desc = "Toggle floating terminal" })

-- Tmux Neovim Naviagator
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>")
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>")
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>")
map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>")

-- ========================================
-- LEGACY KEYMAPS INTEGRATION
-- ========================================

-- Visual mode line movement
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down in visual selection" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up in visual selection" })

-- Navigation enhancements
map("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })
map("n", "<A-j>", "10jzz", { desc = "Jump 10 lines down" })
map("n", "<A-k>", "10kzz", { desc = "Jump 10 lines up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up centered" })
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Word navigation (Alt+h/l for normal/visual only, keep insert mode Alt+h/j/k/l as is)
map("n", "<A-h>", "b", { desc = "Move to previous word" })
map("n", "<A-l>", "w", { desc = "Move to next word" })
map("v", "<A-h>", "b", { desc = "Select to previous word" })
map("v", "<A-l>", "w", { desc = "Select to next word" })
map("n", "<A-S-h>", "vb", { desc = "Select to previous word" })
map("n", "<A-S-l>", "ve", { desc = "Select to next word" })
map("v", "<A-S-h>", "b", { desc = "Extend selection backward" })
map("v", "<A-S-l>", "e", { desc = "Extend selection forward" })

-- Visual mode indenting (keep selection)
map("v", "<", "<gv", { desc = "Indent left and keep selection" })
map("v", ">", ">gv", { desc = "Indent right and keep selection" })

-- Clipboard operations
map("x", "<leader>p", [["_dP]], { desc = "Paste without yanking deleted" })
map("v", "p", '"_dp', { desc = "Paste without yanking" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
map({ "n", "v" }, "<leader>dd", [["_d]], { desc = "Delete without yanking" })

-- VSCode-style editing
map("i", "<C-BS>", "<C-w>", { desc = "Delete word backward" })
map("i", "<C-H>", "<C-w>", { desc = "Delete word backward (alternative)" })
map("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlight" })

-- VSCode-style comment toggle (Ctrl+/)
map("n", "<C-/>", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<C-/>", "gc", { desc = "Toggle comment", remap = true })
map("i", "<C-/>", "<Esc>gcca", { desc = "Toggle comment", remap = true })

-- Format with LSP
map("n", "<leader>f", function()
  vim.lsp.buf.format()
end, { desc = "Format with LSP" })

-- Search & Replace
map("n", "<C-f>", "<cmd>Telescope live_grep<CR>", { desc = "Find in files (Ctrl+F)" })
map(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word globally" }
)
map(
  "n",
  "<leader>sr",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left><Left>]],
  { desc = "Replace word with confirmation" }
)
map("v", "<leader>s", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace in selection" })

-- File operations
map("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { desc = "Make file executable" })
map("n", "<leader>fp", function()
  local filePath = vim.fn.expand "%:~"
  vim.fn.setreg("+", filePath)
  print("File path copied: " .. filePath)
end, { desc = "Copy file path to clipboard" })

-- Tmux integration
map("n", "<leader>tm", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "New tmux session" })

-- Quick save shortcuts (keeping current + legacy)
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>W", "<cmd>wa<CR>", { desc = "Save ALL files" })

-- Buffer/Tab management (bufferline shows buffers as tabs)
map("n", "<leader>to", "<cmd>enew<CR>", { desc = "Open new buffer" })
map("n", "<leader>tx", "<cmd>bdelete<CR>", { desc = "Close current buffer/tab" })
map("n", "<leader>tn", "<cmd>bnext<CR>", { desc = "Go to next buffer/tab" })
map("n", "<leader>tp", "<cmd>bprevious<CR>", { desc = "Go to previous buffer/tab" })
map("n", "<leader>tf", "<cmd>enew | r #<CR>", { desc = "Open current file in new buffer" })

-- Split management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- LSP diagnostics
local isLspDiagnosticsVisible = true
map("n", "<leader>lx", function()
  isLspDiagnosticsVisible = not isLspDiagnosticsVisible
  vim.diagnostic.config {
    virtual_text = isLspDiagnosticsVisible,
    underline = isLspDiagnosticsVisible,
  }
end, { desc = "Toggle LSP diagnostics" })

map("n", "<leader>li", function()
  vim.lsp.buf.code_action {
    context = {
      only = { "source.addImports" },
      diagnostics = {},
    },
  }
end, { desc = "LSP: Organize Imports" })

-- Telescope keymaps
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find Buffers" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent Files" })
map("n", "<leader>fw", "<cmd>Telescope grep_string<CR>", { desc = "Find Word under cursor" })
map("n", "<leader>fc", "<cmd>Telescope commands<CR>", { desc = "Find Commands" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find Help" })

-- Nvim-tree keymaps
map("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
map("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Find current file in explorer" })
map("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse all folders" })
map("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

-- Prevent unwanted behavior
map("n", "Q", "<nop>", { desc = "Disable Q" })
map("n", "x", '"_x', { desc = "Delete char without yanking" })

-- Highlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
