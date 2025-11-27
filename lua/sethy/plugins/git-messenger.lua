return {
    "rhysd/git-messenger.vim",
    keys = {
        { "<leader>gm", "<cmd>GitMessenger<cr>", desc = "Git Messenger: Show commit message" },
    },
    config = function()
        -- Show commit message in a popup (like VSCode's Git Lens)
        vim.g.git_messenger_always_into_popup = true
        vim.g.git_messenger_floating_win_opts = { border = 'rounded' }
        vim.g.git_messenger_popup_content_margins = true
        vim.g.git_messenger_include_diff = "current"
        vim.g.git_messenger_max_popup_height = 40
        vim.g.git_messenger_max_popup_width = 100
        vim.g.git_messenger_date_format = "%Y-%m-%d %H:%M"
    end,
}
