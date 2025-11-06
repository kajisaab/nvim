return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "buffers", -- set to "tabs" to only show tabpages instead
			themable = true,
			numbers = "none", -- can be "none" | "ordinal" | "buffer_id" | "both"
			close_command = "bdelete! %d", -- can be a string | function
			right_mouse_command = "bdelete! %d",
			left_mouse_command = "buffer %d",
			middle_mouse_command = nil,
			indicator = {
				icon = "▎", -- this should be omitted if indicator style is not 'icon'
				style = "icon", -- can be 'icon' or 'underline'|'none'
			},
			buffer_close_icon = "󰅖",
			modified_icon = "●", -- Icon for modified files
			close_icon = "",
			left_trunc_marker = "",
			right_trunc_marker = "",
			max_name_length = 18,
			max_prefix_length = 15,
			truncate_names = true,
			tab_size = 18,
			diagnostics = "nvim_lsp", -- Show LSP diagnostics in bufferline
			diagnostics_update_in_insert = false,
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,
			-- Show modified indicator more prominently
			custom_filter = function(buf_number, buf_numbers)
				-- Don't show certain filetypes
				local filetype = vim.bo[buf_number].filetype
				if filetype == "qf" or filetype == "fugitive" then
					return false
				end
				return true
			end,
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "center",
					separator = true,
				},
			},
			color_icons = true,
			show_buffer_icons = true,
			show_buffer_close_icons = true,
			show_close_icon = true,
			show_tab_indicators = true,
			show_duplicate_prefix = true,
			persist_buffer_sort = true,
			separator_style = "slant", -- can be "slant" | "padded_slant" | "slope" | "padded_slope" | "thick" | "thin"
			enforce_regular_tabs = false,
			always_show_bufferline = true,
			hover = {
				enabled = true,
				delay = 200,
				reveal = { "close" },
			},
			sort_by = "insert_after_current",
		},
		highlights = {
			-- Modified buffer (unsaved) - Make it very obvious!
			buffer_selected = {
				bold = true,
				italic = false,
			},
			modified = {
				fg = "#ff9e64", -- Orange color for modified indicator
			},
			modified_visible = {
				fg = "#ff9e64",
			},
			modified_selected = {
				fg = "#ff9e64", -- Orange color for modified indicator
				bold = true,
			},
		},
	},
}
