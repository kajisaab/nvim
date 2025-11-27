return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        -- "saghen/blink.cmp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        -- NOTE: LSP Keybinds

        -- Auto-organize imports on save for TypeScript/JavaScript
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("AutoOrganizeImports", { clear = true }),
            pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
            callback = function(args)
                local clients = vim.lsp.get_clients({ bufnr = args.buf })
                for _, client in ipairs(clients) do
                    if client.name == "typescript-tools" or client.name == "ts_ls" then
                        -- Organize imports before saving
                        vim.lsp.buf.code_action({
                            apply = true,
                            context = {
                                only = { "source.organizeImports" },
                                diagnostics = {},
                            },
                        })
                        -- Small delay to ensure code action completes
                        vim.wait(100)
                        break
                    end
                end
            end,
        })

        -- Auto-organize imports on save for Java
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("AutoOrganizeImportsJava", { clear = true }),
            pattern = { "*.java" },
            callback = function(args)
                local clients = vim.lsp.get_clients({ bufnr = args.buf })
                for _, client in ipairs(clients) do
                    if client.name == "jdtls" then
                        -- Organize imports before saving
                        vim.lsp.buf.code_action({
                            apply = true,
                            context = {
                                only = { "source.organizeImports" },
                                diagnostics = {},
                            },
                        })
                        vim.wait(100)
                        break
                    end
                end
            end,
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings
                -- Check `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true }

                -- keymaps
                opts.desc = "Show LSP references"
                vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

                opts.desc = "Go to declaration"
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = "Show LSP definitions"
                vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

                opts.desc = "Show LSP implementations"
                vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations (capital I to avoid conflict with built-in gi)

                opts.desc = "Show LSP type definitions"
                vim.keymap.set("n", "gy", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions (y for type to avoid conflict with built-in gt)

                opts.desc = "See available code actions"
                vim.keymap.set({ "n", "v" }, "<leader>vca", function() vim.lsp.buf.code_action() end, opts) -- see available code actions, in visual mode will apply to selection

                opts.desc = "Quick fix (implement interface/fix error)"
                vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.code_action() end, opts)

                opts.desc = "Implement all interface methods"
                vim.keymap.set("n", "<leader>cm", function()
                    vim.lsp.buf.code_action({
                        apply = true,
                        context = {
                            only = { "source.fixAll", "quickfix" },
                            diagnostics = {},
                        },
                    })
                end, opts)

                opts.desc = "Smart rename"
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show buffer diagnostics"
                vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

                opts.desc = "Show line diagnostics"
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Show documentation for what is under cursor"
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

                opts.desc = "Add missing imports"
                vim.keymap.set("n", "<leader>ca", function()
                    vim.lsp.buf.code_action({
                        apply = true,
                        context = {
                            only = { "source.addMissingImports.ts" },
                            diagnostics = {},
                        },
                    })
                end, opts)

                opts.desc = "Organize imports"
                vim.keymap.set("n", "<leader>co", function()
                    vim.lsp.buf.code_action({
                        apply = true,
                        context = {
                            only = { "source.organizeImports" },
                            diagnostics = {},
                        },
                    })
                end, opts)

                opts.desc = "Remove unused imports"
                vim.keymap.set("n", "<leader>cr", function()
                    vim.lsp.buf.code_action({
                        apply = true,
                        context = {
                            only = { "source.removeUnused.ts", "source.removeUnusedImports" },
                            diagnostics = {},
                        },
                    })
                end, opts)

                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end,
        })


        -- NOTE : Moved all this to Mason including local variables
        -- used to enable autocompletion (assign to every lsp server config)
        -- local capabilities = cmp_nvim_lsp.default_capabilities()
        -- Change the Diagnostic symbols in the sign column (gutter)

        -- Define sign icons for each severity
        local signs = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰠠 ",
            [vim.diagnostic.severity.INFO]  = " ",
        }

        -- Set the diagnostic config with all icons
        vim.diagnostic.config({
            signs = {
                text = signs -- Enable signs in the gutter
            },
            virtual_text = true,  -- Enable virtual text for diagnostics (like VSCode)
            underline = true,     -- Underline diagnostics
            update_in_insert = true,  -- Update diagnostics while typing (like VSCode)
            severity_sort = true,  -- Sort by severity
            float = {
                border = "rounded",
                source = "always",  -- Show source of diagnostic
                header = "",
                prefix = "",
            },
        })

        -- Force diagnostics to update in insert mode (aggressive real-time diagnostics)
        vim.api.nvim_create_autocmd({ "TextChangedI", "TextChangedP" }, {
            group = vim.api.nvim_create_augroup("DiagnosticsInsertMode", { clear = true }),
            callback = function()
                -- Trigger diagnostic update while typing
                vim.diagnostic.show(nil, 0)
            end,
        })


        -- NOTE : 
        -- Moved back from mason_lspconfig.setup_handlers from mason.lua file
        -- as mason setup_handlers is deprecated & its causing issues with lsp settings
        --
        -- Setup servers using new vim.lsp.config API
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Config lsp servers here using new API
        -- lua_ls
        vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    completion = {
                        callSnippet = "Replace",
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })

        -- emmet_ls
        vim.lsp.config("emmet_ls", {
            capabilities = capabilities,
            filetypes = {
                "html",
                "typescriptreact",
                "javascriptreact",
                "css",
                "sass",
                "scss",
                "less",
                "svelte",
            },
        })

        -- emmet_language_server
        vim.lsp.config("emmet_language_server", {
            capabilities = capabilities,
            filetypes = {
                "css",
                "eruby",
                "html",
                "javascript",
                "javascriptreact",
                "less",
                "sass",
                "scss",
                "pug",
                "typescriptreact",
            },
            init_options = {
                includeLanguages = {},
                excludeLanguages = {},
                extensionsPath = {},
                preferences = {},
                showAbbreviationSuggestions = true,
                showExpandedAbbreviation = "always",
                showSuggestionsAsSnippets = false,
                syntaxProfiles = {},
                variables = {},
            },
        })

        -- denols
        vim.lsp.config("denols", {
            capabilities = capabilities,
            root_patterns = { "deno.json", "deno.jsonc" },
        })

        -- ts_ls (replaces tsserver)
        -- NOTE: Disabled in favor of typescript-tools.nvim for better auto-import experience
        -- If you want to use ts_ls instead, comment out the typescript-tools.nvim plugin
        -- and uncomment this configuration
        -- vim.lsp.config("ts_ls", {
        --     capabilities = capabilities,
        --     root_patterns = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
        --     single_file_support = false,
        --     init_options = {
        --         preferences = {
        --             includeCompletionsWithSnippetText = true,
        --             includeCompletionsForImportStatements = true,
        --             includeAutomaticOptionalChainCompletions = true,
        --             includeCompletionsForModuleExports = true,
        --             includeInlayParameterNameHints = "all",
        --             includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --             includeInlayFunctionParameterTypeHints = true,
        --             includeInlayVariableTypeHints = true,
        --             includeInlayPropertyDeclarationTypeHints = true,
        --             includeInlayFunctionLikeReturnTypeHints = true,
        --             includeInlayEnumMemberValueHints = true,
        --             importModuleSpecifierPreference = "relative",
        --             importModuleSpecifierEnding = "auto",
        --         },
        --     },
        -- })

        -- clangd (C/C++)
        vim.lsp.config("clangd", {
            capabilities = capabilities,
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders",
            },
        })

        -- pyright (Python)
        vim.lsp.config("pyright", {
            capabilities = capabilities,
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        diagnosticMode = "workspace",
                        useLibraryCodeForTypes = true,
                    },
                },
            },
        })

        -- gopls (Go)
        vim.lsp.config("gopls", {
            capabilities = capabilities,
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                        shadow = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                },
            },
        })

        -- rust_analyzer (Rust)
        vim.lsp.config("rust_analyzer", {
            capabilities = capabilities,
            settings = {
                ["rust-analyzer"] = {
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                        runBuildScripts = true,
                    },
                    checkOnSave = {
                        command = "clippy",
                        allFeatures = true,
                    },
                    procMacro = {
                        enable = true,
                        ignored = {
                            ["async-trait"] = { "async_trait" },
                            ["napi-derive"] = { "napi" },
                            ["async-recursion"] = { "async_recursion" },
                        },
                    },
                },
            },
        })




        -- HACK: If using Blink.cmp Configure all LSPs here

        -- ( comment the ones in mason )
        -- local lspconfig = require("lspconfig")
        -- local capabilities = require("blink.cmp").get_lsp_capabilities() -- Import capabilities from blink.cmp

        -- Configure lua_ls
        -- lspconfig.lua_ls.setup({
        --     capabilities = capabilities,
        --     settings = {
        --         Lua = {
        --             diagnostics = {
        --                 globals = { "vim" },
        --             },
        --             completion = {
        --                 callSnippet = "Replace",
        --             },
        --             workspace = {
        --                 library = {
        --                     [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        --                     [vim.fn.stdpath("config") .. "/lua"] = true,
        --                 },
        --             },
        --         },
        --     },
        -- })
        --
        -- -- Configure tsserver (TypeScript and JavaScript)
        -- lspconfig.ts_ls.setup({
        --     capabilities = capabilities,
        --     root_dir = function(fname)
        --         local util = lspconfig.util
        --         return not util.root_pattern('deno.json', 'deno.jsonc')(fname)
        --             and util.root_pattern('tsconfig.json', 'package.json', 'jsconfig.json', '.git')(fname)
        --     end,
        --     single_file_support = false,
        --     on_attach = function(client, bufnr)
        --         -- Disable formatting if you're using a separate formatter like Prettier
        --         client.server_capabilities.documentFormattingProvider = false
        --     end,
        --     init_options = {
        --         preferences = {
        --             includeCompletionsWithSnippetText = true,
        --             includeCompletionsForImportStatements = true,
        --         },
        --     },
        -- })

        -- Add other LSP servers as needed, e.g., eslint, html, etc.
        -- lspconfig.html.setup({ capabilities = capabilities })
        -- lspconfig.cssls.setup({ capabilities = capabilities })
    end,
}
