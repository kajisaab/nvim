return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local colors = {
            color0 = "#092236",
            color1 = "#ff5874",
            color2 = "#c3ccdc",
			color3 = "#1c1e26",
			color6 = "#a1aab8",
			color7 = "#828697",
			color8 = "#ae81ff",
		}
		local my_lualine_theme = {
			replace = {
				a = { fg = colors.color0, bg = colors.color1, gui = "bold" },
				b = { fg = colors.color2, bg = colors.color3 },
			},
			inactive = {
				a = { fg = colors.color6, bg = colors.color3, gui = "bold" },
				b = { fg = colors.color6, bg = colors.color3 },
				c = { fg = colors.color6, bg = colors.color3 },
			},
			normal = {
				a = { fg = colors.color0, bg = colors.color7, gui = "bold" },
				b = { fg = colors.color2, bg = colors.color3 },
				c = { fg = colors.color2, bg = colors.color3 },
			},
			visual = {
				a = { fg = colors.color0, bg = colors.color8, gui = "bold" },
				b = { fg = colors.color2, bg = colors.color3 },
			},
			insert = {
				a = { fg = colors.color0, bg = colors.color2, gui = "bold" },
				b = { fg = colors.color2, bg = colors.color3 },
			},
		}

        local mode = {
            'mode',
            fmt = function(str)
                -- return ' ' 
                -- displays only the first character of the mode
                return ' ' .. str
            end,
        }

        local diff = {
            'diff',
            colored = true,
            symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
            -- cond = hide_in_width,
        }

        local filename = {
            'filename',
            file_status = true,  -- Shows [+] for modified, [RO] for readonly
            path = 1,            -- 0 = just filename, 1 = relative path, 2 = absolute path
            symbols = {
                modified = '[●]',      -- Text to show when file is modified
                readonly = '[🔒]',     -- Text to show when file is readonly
                unnamed = '[No Name]', -- Text to show for unnamed buffers
                newfile = '[New]',     -- Text to show for new files
            },
            color = function()
                -- Change color if file is modified
                if vim.bo.modified then
                    return { fg = '#ff9e64', gui = 'bold' }  -- Orange/yellow for modified
                end
                return nil
            end,
        }

        local branch = {'branch', icon = {'', color={fg='#A6D4DE'}}, '|'}


		lualine.setup({
            icons_enabled = true,
			options = {
				theme = my_lualine_theme,
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "|", right = "" },
			},
			sections = {
                lualine_a = { mode },
                lualine_b = { branch },
                lualine_c = { diff, filename },
				lualine_x = {
					{
                        -- require("noice").api.statusline.mode.get,
                        -- cond = require("noice").api.statusline.mode.has,
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					-- { "encoding",},
					-- { "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
