-- ╭──────────────────────────────────────────────────────────╮
-- │                    Auto Commands                         │
-- │         Helpful automatic behaviors and utilities        │
-- ╰──────────────────────────────────────────────────────────╯

local config = require("sethy.config")

-- ╭──────────────────────────────────────────────────────────╮
-- │                  Highlight on Yank                       │
-- ╰──────────────────────────────────────────────────────────╯

if config.utils.highlight_yank then
	vim.api.nvim_create_autocmd("TextYankPost", {
		group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
		pattern = "*",
		callback = function()
			vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
		end,
		desc = "Highlight yanked text",
	})
end

-- ╭──────────────────────────────────────────────────────────╮
-- │               Auto-trim Trailing Whitespace              │
-- ╰──────────────────────────────────────────────────────────╯

if config.utils.trim_whitespace then
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("trim_whitespace", { clear = true }),
		pattern = "*",
		callback = function()
			-- Save cursor position
			local save_cursor = vim.fn.getpos(".")
			-- Remove trailing whitespace
			vim.cmd([[%s/\s\+$//e]])
			-- Restore cursor position
			vim.fn.setpos(".", save_cursor)
		end,
		desc = "Remove trailing whitespace on save",
	})
end

-- ╭──────────────────────────────────────────────────────────╮
-- │            Automatically Create Parent Directories        │
-- ╰──────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
	desc = "Automatically create parent directories when saving a file",
})

-- ╭──────────────────────────────────────────────────────────╮
-- │              Resize Splits on Window Resize              │
-- ╰──────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
	desc = "Resize splits when window is resized",
})

-- ╭──────────────────────────────────────────────────────────╮
-- │             Close Certain Windows with 'q'               │
-- ╰──────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
	pattern = {
		"qf",
		"help",
		"man",
		"notify",
		"lspinfo",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"PlenaryTestPopup",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
	desc = "Close certain windows with 'q'",
})

-- ╭──────────────────────────────────────────────────────────╮
-- │            Auto-open vsplit when NvimTree only           │
-- ╰──────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		vim.api.nvim_create_autocmd("BufWinEnter", {
			pattern = "*",
			callback = function()
				local ok, view = pcall(require, "nvim-tree.view")
				if not ok then
					return
				end

				if vim.fn.winnr("$") == 1 and view.is_visible() then
					vim.cmd("vsplit")
				end
			end,
		})
	end,
})

-- ╭──────────────────────────────────────────────────────────╮
-- │              Check for External File Changes             │
-- ╰──────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = vim.api.nvim_create_augroup("checktime", { clear = true }),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
	desc = "Check for external file changes when focus is gained",
})

-- ╭──────────────────────────────────────────────────────────╮
-- │                  Go to Last Location                     │
-- ╰──────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("last_loc", { clear = true }),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
			return
		end
		vim.b[buf].last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
	desc = "Go to last location when opening a buffer",
})

-- ╭──────────────────────────────────────────────────────────╮
-- │              Better Terminal Behavior                    │
-- ╰──────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom_term", { clear = true }),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.scrolloff = 0
	end,
	desc = "Better terminal behavior",
})

-- ╭──────────────────────────────────────────────────────────╮
-- │                 Auto-format on Save                      │
-- ╰──────────────────────────────────────────────────────────╯

if config.lsp.format_on_save then
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
		pattern = "*",
		callback = function()
			vim.lsp.buf.format({ async = false })
		end,
		desc = "Auto-format on save",
	})
end

-- ╭──────────────────────────────────────────────────────────╮
-- │             Conceal Level for JSON files                 │
-- ╰──────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("json_conceal", { clear = true }),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
	desc = "Don't conceal in JSON files",
})

-- ╭──────────────────────────────────────────────────────────╮
-- │              Spell Check for Certain Files               │
-- ╰──────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
	pattern = { "gitcommit", "markdown", "text" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
	desc = "Enable spell check and wrap for git commits and markdown",
})
