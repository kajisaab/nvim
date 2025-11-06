return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
            formatters = {
                ["markdown-toc"] = {
                    condition = function(_, ctx)
                        for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
                            if line:find("<!%-%- toc %-%->") then
                                return true
                            end
                        end
                    end,
                },
                ["markdownlint-cli2"] = {
                    condition = function(_, ctx)
                        local diag = vim.tbl_filter(function(d)
                            return d.source == "markdownlint"
                        end, vim.diagnostic.get(ctx.buf))
                        return #diag > 0
                    end,
                },
            },
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "ruff" },
                markdown = { "prettier" },
                ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
                sh = { "shfmt" },
			},
			format_on_save = function(bufnr)
                -- Get the file type
                local ft = vim.bo[bufnr].filetype

                -- Auto-format JS/TS files on save with Prettier
                -- lsp_fallback is false to ensure Prettier (with .prettierrc) is always used
                if ft == "javascript" or ft == "typescript" or ft == "javascriptreact" or ft == "typescriptreact" then
                    return {
                        lsp_fallback = false, -- Don't use LSP formatting, use Prettier only
                        async = false,
                        timeout_ms = 2000,
                    }
                end

                -- Auto-format other supported file types
                if ft == "css" or ft == "html" or ft == "json" or ft == "yaml" or ft == "lua" or ft == "svelte" then
                    return {
                        lsp_fallback = true,
                        async = false,
                        timeout_ms = 1000,
                    }
                end

                -- For other files, only format if explicitly requested
                return nil
            end,
		})

		-- Configure individual formatters
		-- Prettier: Use project's .prettierrc if available, otherwise use defaults
		conform.formatters.prettier = {
			-- Only specify stdin-filepath, let Prettier find and use .prettierrc automatically
			args = { "--stdin-filepath", "$FILENAME" },
			-- Prettier will automatically look for:
			-- - .prettierrc
			-- - .prettierrc.json
			-- - .prettierrc.yaml
			-- - .prettierrc.yml
			-- - .prettierrc.js
			-- - prettier.config.js
			-- - package.json (prettier field)
		}
		conform.formatters.shfmt = {
			prepend_args = { "-i", "4" },
		}

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = " Prettier Format whole file or range (in visual mode) with" })
	end,
}
