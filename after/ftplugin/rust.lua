local set = vim.opt_local

-- Rust indentation settings (4 spaces as per Rust convention)
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true

-- Add Rust-specific keybindings (only for this buffer)
vim.keymap.set("n", "<leader>rr", ":!cargo run<CR>",
    { buffer = true, desc = "Cargo run" })
vim.keymap.set("n", "<leader>rb", ":!cargo build<CR>",
    { buffer = true, desc = "Cargo build" })
vim.keymap.set("n", "<leader>rt", ":!cargo test<CR>",
    { buffer = true, desc = "Cargo test" })
vim.keymap.set("n", "<leader>rc", ":!cargo check<CR>",
    { buffer = true, desc = "Cargo check" })
vim.keymap.set("n", "<leader>rcl", ":!cargo clippy<CR>",
    { buffer = true, desc = "Cargo clippy" })
