return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		-- LazyVim-inspired colors (works with any colorscheme)
		local colors = {
			bg = "#1a1b26",
			fg = "#c0caf5",
			yellow = "#e0af68",
			cyan = "#7dcfff",
			darkblue = "#0db9d7",
			green = "#9ece6a",
			orange = "#ff9e64",
			violet = "#bb9af7",
			magenta = "#c678dd",
			blue = "#7aa2f7",
			red = "#f7768e",
		}

		-- Simplified auto theme that works with any colorscheme
		local function get_mode_color()
			local mode_colors = {
				n = colors.blue,
				i = colors.green,
				v = colors.violet,
				V = colors.violet,
				c = colors.orange,
				no = colors.red,
				s = colors.orange,
				S = colors.orange,
				ic = colors.yellow,
				R = colors.red,
				Rv = colors.red,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				["r?"] = colors.cyan,
				["!"] = colors.red,
				t = colors.green,
			}
			return mode_colors[vim.fn.mode()]
		end

		-- Custom components
		local mode = {
			function()
				return ""
			end,
			padding = { left = 1, right = 0 },
			color = function()
				return { fg = get_mode_color(), gui = "bold" }
			end,
		}

		local branch = {
			"branch",
			icon = "",
			color = { gui = "bold" },
		}

		local diff = {
			"diff",
			colored = true,
			symbols = {
				added = " ",
				modified = " ",
				removed = " ",
			},
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.orange },
				removed = { fg = colors.red },
			},
		}

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn", "info", "hint" },
			symbols = {
				error = " ",
				warn = " ",
				info = " ",
				hint = " ",
			},
			colored = true,
			update_in_insert = false,
			always_visible = false,
		}

		local filename = {
			"filename",
			file_status = true,
			newfile_status = true,
			path = 1, -- 0: just filename, 1: relative path, 2: absolute path, 3: absolute path with tilde
			shorting_target = 40,
			symbols = {
				modified = "●",
				readonly = "",
				unnamed = "[No Name]",
				newfile = "",
			},
		}

		local lsp_clients = {
			function()
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				if next(clients) == nil then
					return ""
				end

				local c = {}
				for _, client in pairs(clients) do
					table.insert(c, client.name)
				end
				return "  " .. table.concat(c, "|")
			end,
			color = { gui = "bold" },
		}

		local location = {
			"location",
			padding = { left = 0, right = 1 },
		}

		local progress = {
			"progress",
			padding = { left = 0, right = 0 },
		}

		local lazy_updates = {
			lazy_status.updates,
			cond = lazy_status.has_updates,
			color = { fg = colors.orange },
		}

		-- Setup
		lualine.setup({
			options = {
				icons_enabled = true,
				theme = "auto", -- Uses colorscheme's theme
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "dashboard", "alpha", "starter" },
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true, -- Single statusline for all windows (LazyVim style)
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { branch },
				lualine_c = {
					diff,
					diagnostics,
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					filename,
				},
				lualine_x = {
					lazy_updates,
					lsp_clients,
				},
				lualine_y = {
					progress,
				},
				lualine_z = {
					location,
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "nvim-tree", "toggleterm", "quickfix", "trouble" },
		})
	end,
}
