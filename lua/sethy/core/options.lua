-- Load configuration settings
local config = require("sethy.config")

vim.cmd("let g:netrw_banner = 0")

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

-- Font configuration (from config file)
vim.opt.guifont = config.get_font_string()

-- Line numbers (from config)
vim.opt.nu = config.general.number
vim.opt.relativenumber = config.general.relativenumber

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Tab and indentation (from config)
vim.opt.tabstop = config.general.tabstop
vim.opt.softtabstop = config.general.tabstop
vim.opt.shiftwidth = config.general.shiftwidth
vim.opt.expandtab = config.general.expandtab
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = config.general.wrap

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.inccommand = "split"

-- Search settings (from config)
vim.opt.ignorecase = config.general.ignorecase
vim.opt.smartcase = config.general.smartcase

vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Scrolling and signs (from config)
vim.opt.scrolloff = config.general.scrolloff
vim.opt.signcolumn = "yes"

-- Enable folding (from config, setup in nvim-ufo)
vim.o.foldenable = config.general.foldenable
vim.o.foldmethod = "manual"
vim.o.foldlevel = config.general.foldlevel
vim.o.foldcolumn = "0"

-- Backspace behavior
vim.opt.backspace = { "start", "eol", "indent" }

-- Split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.isfname:append("@-@")
vim.opt.updatetime = config.general.updatetime
vim.opt.colorcolumn = config.general.colorcolumn

-- Clipboard (from config)
vim.opt.clipboard:append(config.general.clipboard)
vim.opt.hlsearch = true

-- Mouse support (from config)
vim.opt.mouse = config.general.mouse

-- gets rid of line with white spaces
vim.g.editorconfig = true

-- Window title - shows filename and modified status
vim.opt.title = true
vim.opt.titlestring = "%t %M" -- %t = filename, %M = modified flag [+]
