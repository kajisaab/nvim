return {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
    init = function()
        -- Configure vim-visual-multi before it loads
        vim.g.VM_theme = "iceblue"
        vim.g.VM_mouse_mappings = 1

        -- Show messages
        vim.g.VM_verbose = 1

        -- VSCode-like keybindings
        vim.g.VM_maps = {
            -- Find and select next occurrence (Ctrl+D works on all platforms)
            ["Find Under"] = "<C-d>",
            ["Find Subword Under"] = "<C-d>",

            -- Skip current and find next
            ["Skip Region"] = "<C-x>",

            -- Select all occurrences (like Ctrl+Shift+L in VSCode)
            ["Select All"] = "<Leader>A",  -- Changed from <C-S-l> which can be problematic

            -- Add cursor above/below (like Ctrl+Alt+Up/Down in VSCode)
            ["Add Cursor Down"] = "<M-Down>",  -- Alt+Down
            ["Add Cursor Up"] = "<M-Up>",      -- Alt+Up

            -- Visual Multi cursor mode
            ["Visual Cursors"] = "<Leader>v",

            -- Undo/Redo cursors
            ["Undo"] = "u",
            ["Redo"] = "<C-r>",

            -- Switch mode
            ["Switch Mode"] = "<Tab>",
        }

        -- Disable default mappings to avoid conflicts
        vim.g.VM_default_mappings = 0

        -- Leader key for VM
        vim.g.VM_leader = "\\"

        -- Set custom motions
        vim.g.VM_custom_motions = {
            ['^'] = '0',  -- Start of line
            ['$'] = '$',  -- End of line
        }
    end,
}
