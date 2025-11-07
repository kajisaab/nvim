return {
	"nvim-telescope/telescope.nvim",
	branch = "master", -- using master to fix issues with deprecated to definition warnings 
    -- '0.1.x' for stable ver.
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"andrew-george/telescope-themes",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.load_extension("fzf")
		telescope.load_extension("themes")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
					},
				},
				file_ignore_patterns = {
					"%.jpg", "%.jpeg", "%.png", "%.gif", "%.webp", "%.svg",
					"%.class", "%.o", "%.so", "%.zip", "%.tar", "%.gz",
					"node_modules", "%.DS_Store",
				  },
			},
			extensions = {
				themes = {
					enable_previewer = true,
					enable_live_preview = true,
					persist = {
						enabled = true,
						path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua",
					},
				},
			},
		})

		-- Keymaps

		vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
		vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
		vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find Buffers" })
		vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent Files" })

		-- Alternative search keybindings
		vim.keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<CR>", { desc = "Find Word under cursor" })
		vim.keymap.set("n", "<leader>fc", "<cmd>Telescope commands<CR>", { desc = "Find Commands" })
		vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find Help" })

		-- VSCode-style global search (Ctrl+Shift+F equivalent)
		vim.keymap.set("n", "<C-f>", function()
			builtin.live_grep({
				prompt_title = "Search in Project",
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob=!.git/",
				}
			})
		end, { desc = "Global Search (like VSCode)" })
    end,
}
