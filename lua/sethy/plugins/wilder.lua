return {
	"gelguy/wilder.nvim",
	-- "nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"romgrk/fzy-lua-native",
	},
	config = function()
		local wilder = require("wilder")

		wilder.setup({ modes = { ":", "/", "?" } })

		-- Define custom highlight groups

		-- Set up pipeline for search (/ and ?)
		wilder.set_option("pipeline", wilder.branch(
			wilder.python_search_pipeline({
				pattern = wilder.python_fuzzy_pattern(),
				sorter = wilder.python_difflib_sorter(),
				engine = "re",
			}),
			wilder.cmdline_pipeline(),
			wilder.python_file_finder_pipeline({
				file_command = {"find", ".", "-type", "f", "-printf", "%P\\n"},
				dir_command = {"find", ".", "-type", "d", "-printf", "%P\\n"},
			})
		))

		wilder.set_option(
			"renderer",
			wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
				min_width = "20%", -- minimum height of the popupmenu, can also be a number
				max_height = "15%", -- to set a fixed height, set max_height to the same value
				reverse = 0, -- if 1, shows the candidates from bottom to top
				highlighter = wilder.lua_fzy_highlighter(), -- Using fzy-lua-native (already installed)
				highlights = {
					default = wilder.make_hl(
						"WilderPopupMenu",
						"Pmenu",
						{ { a = 1 }, { a = 1 }, { background = "#1E212B" } } -- Adjust background color
					),
					accent = wilder.make_hl(
						"WilderAccent",
						"Pmenu",
						{ { a = 1 }, { a = 1 }, { foreground = "#58FFD6", background = "#1e1e2e" } }
					),
				},
				-- 'single', 'double', 'rounded' or 'solid'
				-- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
				border = "single",
			}))
		)
	end,
}
