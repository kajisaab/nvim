local set = vim.opt_local

-- C indentation settings (K&R style)
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true

-- Enable C-specific options
set.cindent = true
set.cinoptions = "g0,h1,l1,N-s,t0,(0,W4"

-- Add compile and run keybindings (only for this buffer)
vim.keymap.set("n", "<leader>cc", ":!gcc % -o %:r && ./%:r<CR>",
    { buffer = true, desc = "Compile and run C file" })
vim.keymap.set("n", "<leader>cb", ":!gcc % -o %:r<CR>",
    { buffer = true, desc = "Compile C file" })
