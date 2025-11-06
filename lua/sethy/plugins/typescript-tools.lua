return {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
        local api = require("typescript-tools.api")
        require("typescript-tools").setup({
            on_attach = function(client, bufnr)
                -- Disable typescript-tools formatting in favor of Prettier
                -- This ensures .prettierrc is always respected
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false

                -- TypeScript-specific keybindings
                local opts = { buffer = bufnr, silent = true }

                -- Implement missing interface members
                opts.desc = "Implement interface members"
                vim.keymap.set("n", "<leader>cm", function()
                    vim.lsp.buf.code_action({
                        apply = true,
                        context = {
                            only = { "source.fixAll.ts", "quickfix" },
                            diagnostics = vim.diagnostic.get(bufnr),
                        },
                    })
                end, opts)

                -- Add all missing imports
                opts.desc = "Add all missing imports"
                vim.keymap.set("n", "<leader>cA", function()
                    vim.lsp.buf.code_action({
                        apply = true,
                        context = {
                            only = { "source.addMissingImports.ts" },
                            diagnostics = {},
                        },
                    })
                end, opts)
            end,
            settings = {
                -- Spawn additional tsserver instance to calculate diagnostics on it
                separate_diagnostic_server = true,
                -- "change"|"insert_leave" determine when the client asks the server about diagnostic
                publish_diagnostic_on = "change",  -- Show diagnostics while typing in insert mode!
                -- String|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
                -- not exists then standard path resolution strategy is applied
                tsserver_path = nil,
                -- Specify max file size for typescript server to analyze
                tsserver_max_memory = "auto",
                -- Locale of all tsserver messages, supported locales you can find here:
                -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
                tsserver_locale = "en",
                -- Mirror of VSCode's `typescript.suggest.completeFunctionCalls`
                complete_function_calls = false,
                include_completions_with_insert_text = true,
                -- CodeLens
                code_lens = "off",
                -- By default code lenses are displayed on all referencable values and for some of you it can
                -- be too much this option reduce count of them by removing member references from lenses
                disable_member_code_lens = true,
                -- Experimental setting for inlay hints
                expose_as_code_action = "all",
                -- Inlay Hints
                jsx_close_tag = {
                    enable = false,
                    filetypes = { "javascriptreact", "typescriptreact" },
                },
                -- Import preferences
                tsserver_file_preferences = {
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                    -- Import module specifier preferences
                    importModuleSpecifierPreference = "non-relative",
                    -- Quote style
                    quotePreference = "double",
                    -- Include auto-imports
                    includeCompletionsForModuleExports = true,
                    includeCompletionsWithInsertText = true,
                },
            },
        })
    end,
}
