local set = vim.opt_local

-- Go uses tabs by default (as per Go convention)
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = false  -- Go uses tabs, not spaces

-- Add Go-specific keybindings (only for this buffer)
vim.keymap.set("n", "<leader>gr", ":!go run %<CR>",
    { buffer = true, desc = "Run Go file" })
vim.keymap.set("n", "<leader>gb", ":!go build<CR>",
    { buffer = true, desc = "Build Go project" })
vim.keymap.set("n", "<leader>gt", ":!go test ./...<CR>",
    { buffer = true, desc = "Run Go tests" })
