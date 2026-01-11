-- ╭──────────────────────────────────────────────────────────╮
-- │                  Neovim Configuration                    │
-- │         Centralized settings for easy tweaking           │
-- ╰──────────────────────────────────────────────────────────╯

local M = {}

-- ╭──────────────────────────────────────────────────────────╮
-- │                    General Settings                      │
-- ╰──────────────────────────────────────────────────────────╯

M.general = {
	-- Leader key (must be set before lazy.nvim loads)
	leader = " ",

	-- Font settings (for GUI clients like Neovide)
	font = {
		name = "Monaspace Radon",
		size = 10,
	},

	-- Line numbers
	number = true,
	relativenumber = false,

	-- Tab and indentation
	tabstop = 4,
	shiftwidth = 4,
	expandtab = true, -- Use spaces instead of tabs

	-- Editor behavior
	wrap = false, -- Line wrapping
	scrolloff = 8, -- Lines to keep above/below cursor
	colorcolumn = "80", -- Visual guide at column 80

	-- Search
	ignorecase = true,
	smartcase = true, -- Case-sensitive if uppercase is used

	-- System integration
	clipboard = "unnamedplus", -- Use system clipboard
	mouse = "a", -- Enable mouse support

	-- Performance
	updatetime = 50, -- Faster completion and diagnostics

	-- Folding
	foldenable = true,
	foldlevel = 99, -- Open most folds by default
}

-- ╭──────────────────────────────────────────────────────────╮
-- │                  Statusline Settings                     │
-- ╰──────────────────────────────────────────────────────────╯

M.statusline = {
	-- Use global statusline (single statusline for all windows)
	globalstatus = true,

	-- Show LSP client names in statusline
	show_lsp_clients = true,

	-- Show diagnostics count
	show_diagnostics = true,

	-- Show git diff stats
	show_git_diff = true,

	-- Theme (uses colorscheme theme by default)
	theme = "auto",
}

-- ╭──────────────────────────────────────────────────────────╮
-- │                    Colorscheme                           │
-- ╰──────────────────────────────────────────────────────────╯

M.colorscheme = {
	-- Available: "tokyonight", "rose-pine", "gruvbox", "kanagawa"
	name = "tokyonight",

	-- Transparency (only for supported themes)
	transparent = false,

	-- Tokyo Night specific
	tokyonight = {
		style = "night", -- Options: storm, night, moon, day
	},
}

-- ╭──────────────────────────────────────────────────────────╮
-- │                  LSP & Completion                        │
-- ╰──────────────────────────────────────────────────────────╮

M.lsp = {
	-- Auto-format on save
	format_on_save = false,

	-- Show diagnostic signs in gutter
	diagnostic_signs = true,

	-- Virtual text for diagnostics
	virtual_text = true,

	-- Servers to ensure installed
	servers = {
		"lua_ls",
		"pyright",
		"html",
		"cssls",
		"tailwindcss",
		"clangd",
		"gopls",
		"rust_analyzer",
		"jdtls",
		"marksman",
	},
}

-- ╭──────────────────────────────────────────────────────────╮
-- │                  File Explorer                           │
-- ╰──────────────────────────────────────────────────────────╯

M.file_explorer = {
	-- Auto-open nvim-tree on startup (if directory)
	auto_open = false,

	-- Width of the tree window
	width = 30,

	-- Show hidden files
	show_hidden = true,

	-- Show git status
	git_integration = true,
}

-- ╭──────────────────────────────────────────────────────────╮
-- │                   Git Integration                        │
-- ╰──────────────────────────────────────────────────────────╯

M.git = {
	-- Show git signs in gutter
	signs_enabled = true,

	-- Show git blame in statusline
	blame_line = false,

	-- LazyGit integration (requires lazygit installed)
	use_lazygit = true,
}

-- ╭──────────────────────────────────────────────────────────╮
-- │                  Completion Settings                     │
-- ╰──────────────────────────────────────────────────────────╯

M.completion = {
	-- Enable auto-completion
	enabled = true,

	-- Max items to show in completion menu
	max_items = 10,

	-- Show documentation in completion
	documentation = true,

	-- Enable snippets
	snippets = true,
}

-- ╭──────────────────────────────────────────────────────────╮
-- │                  Plugin Management                       │
-- ╰──────────────────────────────────────────────────────────╯

M.plugins = {
	-- Auto-install plugins on startup
	auto_install = true,

	-- Check for updates
	check_updates = true,

	-- Performance: lazy-load plugins
	lazy_load = true,
}

-- ╭──────────────────────────────────────────────────────────╮
-- │                  Session Management                      │
-- ╰──────────────────────────────────────────────────────────╯

M.session = {
	-- Auto-save session on exit
	auto_save = true,

	-- Auto-restore session on startup
	auto_restore = false,
}

-- ╭──────────────────────────────────────────────────────────╮
-- │                  Helpful Utilities                       │
-- ╰──────────────────────────────────────────────────────────╯

M.utils = {
	-- Auto-remove trailing whitespace on save
	trim_whitespace = true,

	-- Highlight on yank
	highlight_yank = true,

	-- Auto-pairs (brackets, quotes, etc.)
	auto_pairs = true,

	-- Comment shortcuts
	comments = true,
}

-- ╭──────────────────────────────────────────────────────────╮
-- │                  Helper Functions                        │
-- ╰──────────────────────────────────────────────────────────╯

-- Get the full font string for GUI
function M.get_font_string()
	return M.general.font.name .. ":h" .. M.general.font.size
end

-- Check if a feature is enabled
function M.is_enabled(category, feature)
	if M[category] and M[category][feature] ~= nil then
		return M[category][feature]
	end
	return false
end

return M
