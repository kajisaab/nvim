return {
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "neovim/nvim-lspconfig",
        -- "saghen/blink.cmp",
    },
    config = function()
        -- import mason and mason_lspconfig
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        -- NOTE: Moved these local imports below back to lspconfig.lua due to mason depracated handlers

        -- local lspconfig = require("lspconfig")
        -- local cmp_nvim_lsp = require("cmp_nvim_lsp")             -- import cmp-nvim-lsp plugin
        -- local capabilities = cmp_nvim_lsp.default_capabilities() -- used to enable autocompletion (assign to every lsp server config)

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            automatic_enable = false,
            -- servers for mason to install
            ensure_installed = {
                "lua_ls",
                "pyright",   -- python LSP
                "html",
                "cssls",
                "tailwindcss",
                "emmet_ls",
                "emmet_language_server",
                "clangd",    -- C/C++ LSP
                "gopls",     -- Go LSP
                "rust_analyzer", -- Rust LSP
                "jdtls",     -- Java LSP
                "marksman",
            },

        })

        mason_tool_installer.setup({
            ensure_installed = {
                "prettier", -- prettier formatter
                "stylua",   -- lua formatter
                "ruff",     -- python formatter and linter (replaces isort & black)
                "pylint",   -- python linter
                "pyright",  -- python LSP
                "clangd",   -- C/C++ LSP
                "clang-format", -- C/C++ formatter
                "cpplint",  -- C/C++ linter
                "gopls",    -- Go LSP
                "gofumpt",  -- Go formatter (stricter than gofmt)
                "goimports", -- Go imports formatter
                "golangci-lint", -- Go linter
                "rust_analyzer", -- Rust LSP
                "rustfmt",  -- Rust formatter
                "jdtls",    -- Java LSP
                "denols",
                "eslint_d",
            },

            -- NOTE: mason BREAKING Change! Removed setup_handlers
            -- moved lsp configuration settings back into lspconfig.lua file
        })
    end,
}
