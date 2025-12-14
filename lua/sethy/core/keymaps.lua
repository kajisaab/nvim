local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("n", "J", "mzJ`z")
-- Jump 10 lines up/down with Alt+j/k (Ctrl+d is used for multi-cursor)
vim.keymap.set("n", "<A-j>", "10jzz", { desc = "Jump 10 lines down", silent = true })
vim.keymap.set("n", "<A-k>", "10kzz", { desc = "Jump 10 lines up", silent = true })
-- Half-page scroll with Ctrl+j/k (centered)
vim.keymap.set("n", "<C-j>", "<C-d>zz", { desc = "Half page down with cursor centered", silent = true })
vim.keymap.set("n", "<C-k>", "<C-u>zz", { desc = "Half page up with cursor centered", silent = true })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- the how it be paste
vim.keymap.set("x", "<leader>p", [["_dP]])

-- remember yanked
vim.keymap.set("v", "p", '"_dp', opts)

-- Copies or Yank to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]], opts)

-- leader dd delete wont remember as yanked/clipboard when delete pasting
-- Changed from <leader>d to <leader>dd to avoid conflict with LSP diagnostics
vim.keymap.set({ "n", "v" }, "<leader>dd", [["_d]], { desc = "Delete without yanking" })

-- ctrl c as escape cuz Im lazy to reach up to the esc key
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search hl", silent = true })

-- IDE-style word deletion with Ctrl+Backspace (in insert mode)
vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "Delete word backward (Ctrl+Backspace)" })
vim.keymap.set("i", "<C-H>", "<C-w>", { desc = "Delete word backward (Ctrl+Backspace alternative)" })

-- Word navigation with Alt+h/l (Vim-style, no conflicts)
vim.keymap.set("n", "<A-h>", "b", { desc = "Move to previous word", silent = true })
vim.keymap.set("n", "<A-l>", "w", { desc = "Move to next word", silent = true })
vim.keymap.set("i", "<A-h>", "<C-o>b", { desc = "Move to previous word in insert mode", silent = true })
vim.keymap.set("i", "<A-l>", "<C-o>w", { desc = "Move to next word in insert mode", silent = true })
vim.keymap.set("v", "<A-h>", "b", { desc = "Select to previous word in visual mode", silent = true })
vim.keymap.set("v", "<A-l>", "w", { desc = "Select to next word in visual mode", silent = true })

-- Word selection with Alt+Shift+h/l
vim.keymap.set("n", "<A-S-h>", "vb", { desc = "Select to previous word", silent = true })
vim.keymap.set("n", "<A-S-l>", "ve", { desc = "Select to next word", silent = true })
vim.keymap.set("v", "<A-S-h>", "b", { desc = "Extend selection to previous word", silent = true })
vim.keymap.set("v", "<A-S-l>", "e", { desc = "Extend selection to next word", silent = true })

-- VSCode-style comment toggle (Ctrl+/)
vim.keymap.set("n", "<C-/>", "gcc", { desc = "Toggle comment", remap = true })
vim.keymap.set("v", "<C-/>", "gc", { desc = "Toggle comment", remap = true })
vim.keymap.set("i", "<C-/>", "<Esc>gcca", { desc = "Toggle comment", remap = true })
-- format without prettier using the built in
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)

-- Unmaps Q in normal mode
vim.keymap.set("n", "Q", "<nop>")

--Stars new tmux session from in here (moved to <leader>t)
-- Removed <C-f> conflict - now available for page down
vim.keymap.set("n", "<leader>tm", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "New tmux session" })

-- prevent x delete from registering when next paste
vim.keymap.set("n", "x", '"_x', opts)

-- Find and Replace operations
-- IDE-style find (Ctrl+F) - opens Telescope live grep
vim.keymap.set("n", "<C-f>", "<cmd>Telescope live_grep<CR>", { desc = "Find in files (Ctrl+F)" })

-- Replace the word cursor is on globally (like Ctrl+H in VSCode)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word cursor is on globally" })

-- Find and replace with confirmation (interactive)
vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left><Left>]],
    { desc = "Replace word with confirmation" })

-- Find and replace in visual selection
vim.keymap.set("v", "<leader>s", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace in selection" })

-- Executes shell command from in here making file executable
-- Changed from <leader>x to <leader>xx to avoid conflict with buffer close
vim.keymap.set("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Hightlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- tab stuff
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>")   --open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>") --close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>")     --go to next
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>")     --go to pre
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>") --open current tab in new tab

--split management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
-- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
-- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
-- close current split window
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
  local filePath = vim.fn.expand("%:~") -- Gets the file path relative to the home directory
  vim.fn.setreg("+", filePath) -- Copy the file path to the clipboard register
  print("File path copied to clipboard: " .. filePath) -- Optional: print message to confirm
end, { desc = "Copy file path to clipboard" })

-- Open shortcuts documentation
vim.keymap.set("n", "<leader>?", "<cmd>e ~/.config/nvim/KEYMAPS.md<CR>",
  { desc = "Open keymaps reference" })

-- Toggle LSP diagnostics visibility
local isLspDiagnosticsVisible = true
vim.keymap.set("n", "<leader>lx", function()
    isLspDiagnosticsVisible = not isLspDiagnosticsVisible
    vim.diagnostic.config({
        virtual_text = isLspDiagnosticsVisible,
        underline = isLspDiagnosticsVisible
    })
end, { desc = "Toggle LSP diagnostics" })

vim.keymap.set("n", "<leader>li", function()
    vim.lsp.buf.code_action({
      context = {
        only = { "source.addImports" },
        diagnostics = {},
      },
    })
  end, { desc = "LSP: Organize Imports" })


  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.java",
    callback = function()
      vim.lsp.buf.code_action({
        context = {
          only = { "source.addImports" },
        },
      })
    end,
  })

-- ========================================
-- Buffer Management & Save Shortcuts
-- ========================================

-- Quick save shortcuts
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file (Ctrl+S)", silent = true })
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>a", { desc = "Save file in insert mode", silent = true })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file", silent = true })
vim.keymap.set("n", "<leader>W", "<cmd>wa<CR>", { desc = "Save ALL files", silent = true })

-- Buffer navigation (easier than :bnext/:bprev)
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer (Tab)" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer (Shift+Tab)" })

-- Close buffers
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>X", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close all other buffers" })

-- Pick specific buffer
vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })

-- Show all buffers (like VSCode Ctrl+Tab)
vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<CR>", { desc = "List all buffers" })

-- Pin/unpin buffer
vim.keymap.set("n", "<leader>bP", "<cmd>BufferLineTogglePin<CR>", { desc = "Pin/Unpin buffer" })

-- Sort buffers
vim.keymap.set("n", "<leader>bs", "<cmd>BufferLineSortByDirectory<CR>", { desc = "Sort buffers by directory" })

-- Show modified buffers warning on quit
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local modified_buffers = vim.tbl_filter(function(buf)
      return vim.api.nvim_buf_get_option(buf, 'modified')
    end, vim.api.nvim_list_bufs())

    if #modified_buffers > 0 then
      local choice = vim.fn.confirm(
        "You have unsaved changes in " .. #modified_buffers .. " file(s)!\nDo you want to save them?",
        "&Yes\n&No\n&Cancel",
        3
      )

      if choice == 1 then -- Yes
        vim.cmd('wa')  -- Save all
      elseif choice == 3 then -- Cancel
        vim.cmd('stopinsert')
        return true
      end
    end
  end,
})

