-- vim.g.loaded_netrw = 0
-- vim.g.loaded_netrwPlugin = 0
-- vim.cmd("let g:netrw_liststyle = 3")
vim.cmd("let g:netrw_banner = 0 ")

-- Configure nvm Node.js path for Neovim
-- This ensures Neovim plugins can access npm and node from nvm
local nvm_dir = vim.fn.expand("$HOME/.nvm/versions/node")
if vim.fn.isdirectory(nvm_dir) == 1 then
	-- Use the latest installed version (sorted alphabetically, which works for version numbers)
	local versions = vim.fn.globpath(nvm_dir, "v*", false, true)
	if #versions > 0 then
		-- Sort versions to get the latest
		table.sort(versions)
		local latest_version = versions[#versions]
		local nvm_node_path = latest_version .. "/bin"
		if vim.fn.isdirectory(nvm_node_path) == 1 then
			vim.env.PATH = nvm_node_path .. ":" .. vim.env.PATH
		end
	end
end

vim.opt.guicursor = ""

-- Font configuration (for GUI clients like Neovide, neovim-qt, goneovim)
vim.opt.guifont = "Monaspace Radon:h10"

vim.opt.nu = true
vim.opt.relativenumber = false

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.inccommand = "split"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

-- Enable folding ( setup in nvim-ufo )
vim.o.foldenable = true -- Enable folding by default
vim.o.foldmethod = "manual" -- Default fold method (change as needed)
vim.o.foldlevel = 99 -- Open most folds by default
vim.o.foldcolumn = "0"

-- backspace
vim.opt.backspace = { "start", "eol", "indent" }

--split windows
vim.opt.splitright = true --split vertical window to the right
vim.opt.splitbelow = true --split horizontal window to the bottom

vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

-- clipboard
vim.opt.clipboard:append("unnamedplus") --use system clipboard as default
vim.opt.hlsearch = true

-- for easy mouse resizing, just incase
vim.opt.mouse = "a"

-- gets rid of line with white spaces
vim.g.editorconfig = true

-- Window title - shows filename and modified status
vim.opt.title = true
vim.opt.titlestring = "%t %M" -- %t = filename, %M = modified flag [+]

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
