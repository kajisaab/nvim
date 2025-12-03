local set = vim.opt_local

-- Rust indentation settings (4 spaces as per Rust convention)
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true

-- Helper function to find Cargo.toml and get package info
local function find_cargo_root()
    local current_file = vim.fn.expand("%:p:h")
    local cargo_toml = vim.fn.findfile("Cargo.toml", current_file .. ";")
    if cargo_toml ~= "" then
        return vim.fn.fnamemodify(cargo_toml, ":p:h")
    end
    return nil
end

-- Helper function to run cargo commands in the correct directory
local function run_cargo_cmd(cmd, desc)
    return function()
        local cargo_root = find_cargo_root()
        if cargo_root then
            vim.cmd("!" .. string.format("cd '%s' && cargo %s", cargo_root, cmd))
        else
            vim.notify("Cargo.toml not found!", vim.log.levels.ERROR)
        end
    end
end

-- Add Rust-specific keybindings (only for this buffer)
vim.keymap.set("n", "<leader>rr", run_cargo_cmd("run", "Cargo run"),
    { buffer = true, desc = "Cargo run" })
vim.keymap.set("n", "<leader>rb", run_cargo_cmd("build", "Cargo build"),
    { buffer = true, desc = "Cargo build" })
vim.keymap.set("n", "<leader>rB", run_cargo_cmd("build --release", "Cargo build release"),
    { buffer = true, desc = "Cargo build (release)" })
vim.keymap.set("n", "<leader>rt", run_cargo_cmd("test", "Cargo test"),
    { buffer = true, desc = "Cargo test" })
vim.keymap.set("n", "<leader>rc", run_cargo_cmd("check", "Cargo check"),
    { buffer = true, desc = "Cargo check" })
vim.keymap.set("n", "<leader>rcl", run_cargo_cmd("clippy", "Cargo clippy"),
    { buffer = true, desc = "Cargo clippy" })
vim.keymap.set("n", "<leader>ru", run_cargo_cmd("update", "Cargo update"),
    { buffer = true, desc = "Cargo update" })
vim.keymap.set("n", "<leader>rU", run_cargo_cmd("upgrade", "Cargo upgrade"),
    { buffer = true, desc = "Cargo upgrade (edit-cargo)" })
vim.keymap.set("n", "<leader>rd", run_cargo_cmd("doc --open", "Cargo doc"),
    { buffer = true, desc = "Cargo doc (open)" })
