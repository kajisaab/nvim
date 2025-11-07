-- -- Terminal Float State (taught by tj)
-- vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- local state = {
--     floating = {
--         buf = -1,
--         win = -1,
--     }
-- }

-- local function create_floating_window(opts)
--     opts = opts or {}
--     local width = opts.width or math.floor(vim.o.columns * 0.8)
--     local height = opts.height or math.floor(vim.o.lines * 0.8)

--     local col = math.floor((vim.o.columns - width) / 2)
--     local row = math.floor((vim.o.lines - height) / 2)

--     local buf = nil
--     if vim.api.nvim_buf_is_valid(opts.buf) then
--         buf = opts.buf
--     else
--         buf = vim.api.nvim_create_buf(false, true)
--     end

--     local win_config = {
--         relative = "editor",
--         border = "rounded",
--         style = "minimal",
--         width = width,
--         height = height,
--         col = col,
--         row = row,
--     }

--     local win = vim.api.nvim_open_win(buf, true, win_config)

--     return { buf = buf, win = win }
-- end

-- local pop_terminal = function()
--     if not vim.api.nvim_win_is_valid(state.floating.win) then
--         state.floating = create_floating_window { buf = state.floating.buf }
--         if vim.bo[state.floating.buf].buftype ~= "terminal" then
--             vim.cmd.terminal()
--         end

--         -- Start float terminal in insert mode
--         vim.api.nvim_set_current_win(state.floating.win)
--         vim.cmd("startinsert!")

--     else
--         vim.api.nvim_win_hide(state.floating.win)
--     end
-- end

-- vim.api.nvim_create_user_command("Terminalpop", pop_terminal, {})

-- vim.keymap.set({ "n", "t" }, "<C-t>", pop_terminal)



-- Terminal Float State (taught by tj)
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
    floating = {
        buf = -1,
        win = -1,
    }
}

local function create_floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    local win_config = {
        relative = "editor",
        border = "rounded",
        style = "minimal",
        width = width,
        height = height,
        col = col,
        row = row,
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

local pop_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_window { buf = state.floating.buf }
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end

        -- Start float terminal in insert mode
        vim.api.nvim_set_current_win(state.floating.win)
        vim.cmd("startinsert!")

    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end

-- Pop terminal with tmux for splitting capability
local pop_terminal_tmux = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_window { buf = state.floating.buf }
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            -- Start terminal with tmux
            vim.fn.termopen("tmux new-session -A -s nvim-popup")
        end

        -- Start float terminal in insert mode
        vim.api.nvim_set_current_win(state.floating.win)
        vim.cmd("startinsert!")

    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end

vim.api.nvim_create_user_command("Terminalpop", pop_terminal, {})
vim.api.nvim_create_user_command("TerminalpopTmux", pop_terminal_tmux, {})

-- Change this line to use Ctrl+Space instead of Ctrl+t
-- Use Ctrl+b for regular terminal or Ctrl+Shift+b for tmux terminal
vim.keymap.set({ "n", "t" }, "<C-b>", pop_terminal_tmux)  -- Now uses tmux by default

-- Function to convert floating terminal to split mode
local function convert_to_splits()
    -- Check if we're in the floating terminal window
    if vim.api.nvim_win_is_valid(state.floating.win) then
        -- Hide the floating window
        vim.api.nvim_win_hide(state.floating.win)
    end

    -- Open terminal in split mode
    vim.cmd("split")
    vim.cmd("terminal")
    vim.cmd("startinsert")
end

-- Function to split terminal horizontally (works in floating terminal)
local function split_terminal_horizontal()
    if vim.api.nvim_win_is_valid(state.floating.win) and vim.api.nvim_get_current_win() == state.floating.win then
        -- We're in floating terminal, convert to splits
        vim.api.nvim_win_hide(state.floating.win)
        vim.cmd("split")
        vim.cmd("terminal")
        vim.cmd("startinsert")
    else
        -- Regular split
        vim.cmd("split")
        vim.cmd("terminal")
        vim.cmd("startinsert")
    end
end

-- Function to split terminal vertically (works in floating terminal)
local function split_terminal_vertical()
    if vim.api.nvim_win_is_valid(state.floating.win) and vim.api.nvim_get_current_win() == state.floating.win then
        -- We're in floating terminal, convert to splits
        vim.api.nvim_win_hide(state.floating.win)
        vim.cmd("vsplit")
        vim.cmd("terminal")
        vim.cmd("startinsert")
    else
        -- Regular split
        vim.cmd("vsplit")
        vim.cmd("terminal")
        vim.cmd("startinsert")
    end
end

-- Keybindings for splitting terminals (works in both floating and regular terminals)
vim.keymap.set("t", "<C-w>s", function()
    split_terminal_horizontal()
end, { desc = "Split terminal horizontally" })

vim.keymap.set("t", "<C-w>v", function()
    split_terminal_vertical()
end, { desc = "Split terminal vertically" })

-- Navigation between terminal splits (works in terminal mode)
vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h", { desc = "Move to left window" })
vim.keymap.set("t", "<C-w>j", "<C-\\><C-n><C-w>j", { desc = "Move to down window" })
vim.keymap.set("t", "<C-w>k", "<C-\\><C-n><C-w>k", { desc = "Move to up window" })
vim.keymap.set("t", "<C-w>l", "<C-\\><C-n><C-w>l", { desc = "Move to right window" })

-- Close terminal split
vim.keymap.set("t", "<C-w>q", "<C-\\><C-n>:q<CR>", { desc = "Close terminal split" })

-- Auto-enter insert mode when switching to a terminal window
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "term://*",
    callback = function()
        vim.cmd("startinsert")
    end,
})