require "nvchad.autocmds"

-- ========================================
-- LEGACY AUTOCMDS INTEGRATION
-- ========================================

-- Show modified buffers warning on quit
vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
        local modified_buffers = vim.tbl_filter(function(buf)
            return vim.api.nvim_buf_get_option(buf, "modified")
        end, vim.api.nvim_list_bufs())

        if #modified_buffers > 0 then
            local choice = vim.fn.confirm(
                "You have unsaved changes in " .. #modified_buffers .. " file(s)!\nDo you want to save them?",
                "&Yes\n&No\n&Cancel",
                3
            )

            if choice == 1 then
                vim.cmd "wa"
            elseif choice == 3 then
                vim.cmd "stopinsert"
                return true
            end
        end
    end,
})

-- Java: Auto-organize imports on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.java",
    callback = function()
        vim.lsp.buf.code_action {
            context = {
                only = { "source.addImports" },
            },
        }
    end,
})

-- Go: Format and organize imports on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        -- Organize imports
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
        for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
                end
            end
        end
        -- Format the file
        vim.lsp.buf.format({ async = false })
    end,
})

-- Auto-open NvimTree when opening a directory
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function(data)
        -- Check if the argument is a directory
        local directory = vim.fn.isdirectory(data.file) == 1

        if directory then
            -- Change to the directory
            vim.cmd.cd(data.file)

            -- Open NvimTree
            require("nvim-tree.api").tree.open()
        end
    end,
})
