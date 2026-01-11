return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Lazygit integration in Neovim
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit", -- Load plugin only when `:LazyGit` is used
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required dependency for lazygit.nvim
    },
    config = function() end,
  },
  -- VS Code-like template string converter
  {
    "axelvc/template-string.nvim",
    ft = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "svelte",
      "python",
      "cs",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("template-string").setup {
        filetypes = {
          "html",
          "typescript",
          "javascript",
          "typescriptreact",
          "javascriptreact",
          "vue",
          "svelte",
          "python",
          "cs",
        },
        jsx_brackets = true, -- Add brackets in JSX if needed
        remove_template_string = false, -- Do not revert backtick to quotes after editing
        restore_quotes = {
          normal = [[']], -- Use single quotes for normal strings
          jsx = [["]], -- Use double quotes in JSX
        },
      }
    end,
  },
  -- UI enhancement: Replace vim.ui.select with Telescope dropdown
  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    lazy = true,
    config = function()
      local telescope = require "telescope"
      local actions = require "telescope.actions"

      telescope.setup {
        defaults = {
          path_display = { "smart" },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
            },
          },
          file_ignore_patterns = {
            "%.jpg",
            "%.jpeg",
            "%.png",
            "%.gif",
            "%.webp",
            "%.svg",
            "%.class",
            "%.o",
            "%.so",
            "%.zip",
            "%.tar",
            "%.gz",
            "node_modules",
            "%.DS_Store",
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      }

      telescope.load_extension "ui-select"
      telescope.load_extension "fzf"
    end,
  },
  -- Auto-close & rename HTML/JSX tags using Treesitter
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" }, -- Load on file read or new file
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup {
        opts = {
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Rename paired tags
          enable_close_on_slash = false, -- Disable slash-triggered auto-close
        },
        per_filetype = {
          -- Override or disable behavior per filetype if needed
        },
      }
    end,
  },
  --  Markdown rendering and preview
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" }, -- Load plugin only for markdown files
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim", -- or use 'mini.icons' or 'nvim-web-devicons' instead
    },
    config = function()
      require("render-markdown").setup {
        -- Optional: add config here if needed
      }
    end,
  },
  -- Neovim Tmux Navigation
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      preset = "helix", dofile(vim.g.base46_cache .. "whichkey")
      return {
        preset = "helix",
      }
    end,
  },
  -- test new blink
  { import = "nvchad.blink.lazyspec" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "go",
        "yaml",
        "python",
        "http",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "dockerfile",
        "gitignore",
        "query",
        "c",
        "java",
        "rust",
      },
    },
    auto_install = true, -- Automatically install missing parsers
  },

  -- ========================================
  -- DEBUGGING SETUP (nvim-dap)
  -- ========================================
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      { "<Leader>db", desc = "Toggle breakpoint" },
      { "<Leader>dc", desc = "Continue/Start debugging" },
      { "<Leader>dso", desc = "Step over" },
      { "<Leader>dsi", desc = "Step into" },
      { "<Leader>dsx", desc = "Step out" },
      { "<Leader>dr", desc = "Open REPL" },
      { "<Leader>dl", desc = "Run last" },
      { "<Leader>dt", desc = "Toggle DAP UI" },
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      require("mason-nvim-dap").setup {
        ensure_installed = {
          "python",
          "codelldb",
          "delve",
        },
        automatic_installation = true,
        handlers = {},
      }

      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return "python"
          end,
        },
      }

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath "data" .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }
      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
      }

      vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue/Start debugging" })
      vim.keymap.set("n", "<Leader>dso", dap.step_over, { desc = "Step over" })
      vim.keymap.set("n", "<Leader>dsi", dap.step_into, { desc = "Step into" })
      vim.keymap.set("n", "<Leader>dsx", dap.step_out, { desc = "Step out" })
      vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" })
      vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run last" })
      vim.keymap.set("n", "<Leader>dt", dapui.toggle, { desc = "Toggle DAP UI" })
    end,
  },

  -- ========================================
  -- ADVANCED GIT TOOLS
  -- ========================================
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    config = function()
      require("diffview").setup {
        diff_binaries = false,
        enhanced_diff_hl = false,
        git_cmd = { "git" },
        use_icons = true,
        show_help_hints = true,
        watch_index = true,
        icons = {
          folder_closed = "",
          folder_open = "",
        },
        signs = {
          fold_closed = "",
          fold_open = "",
          done = "✓",
        },
        view = {
          default = {
            layout = "diff2_horizontal",
            winbar_info = false,
          },
          merge_tool = {
            layout = "diff3_mixed",
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = {
            layout = "diff2_horizontal",
            winbar_info = false,
          },
        },
      }

      vim.keymap.set("n", "<leader>gdo", "<cmd>DiffviewOpen<cr>", { desc = "Diffview: Open" })
      vim.keymap.set("n", "<leader>gdc", "<cmd>DiffviewClose<cr>", { desc = "Diffview: Close" })
      vim.keymap.set("n", "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", { desc = "Diffview: All File History" })
      vim.keymap.set("n", "<leader>gdf", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview: Current File History" })
      vim.keymap.set("n", "<leader>gdr", "<cmd>DiffviewRefresh<cr>", { desc = "Diffview: Refresh" })
      vim.keymap.set("n", "<leader>gv", "<cmd>DiffviewOpen<cr>", { desc = "Git: Resolve Merge Conflicts" })
      vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Git: File History" })
      vim.keymap.set("v", "<leader>gh", ":'<,'>DiffviewFileHistory<cr>", { desc = "Git: Selection History" })
      vim.keymap.set("n", "<leader>gb", "<cmd>DiffviewFileHistory %<cr>", { desc = "Git: File Blame/History" })
    end,
  },

  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup {
        default_mappings = false,
        default_commands = true,
        disable_diagnostics = false,
        highlights = {
          incoming = "DiffAdd",
          current = "DiffText",
        },
      }

      vim.keymap.set("n", "co", "<cmd>GitConflictChooseOurs<cr>", { desc = "Conflict: Choose Ours" })
      vim.keymap.set("n", "ct", "<cmd>GitConflictChooseTheirs<cr>", { desc = "Conflict: Choose Theirs" })
      vim.keymap.set("n", "cb", "<cmd>GitConflictChooseBoth<cr>", { desc = "Conflict: Choose Both" })
      vim.keymap.set("n", "c0", "<cmd>GitConflictChooseNone<cr>", { desc = "Conflict: Choose None" })
      vim.keymap.set("n", "]x", "<cmd>GitConflictNextConflict<cr>", { desc = "Next Conflict" })
      vim.keymap.set("n", "[x", "<cmd>GitConflictPrevConflict<cr>", { desc = "Previous Conflict" })
      vim.keymap.set("n", "<leader>cl", "<cmd>GitConflictListQf<cr>", { desc = "List All Conflicts" })
    end,
  },

  {
    "rhysd/git-messenger.vim",
    cmd = "GitMessenger",
    keys = {
      { "<leader>gm", "<cmd>GitMessenger<cr>", desc = "Git Messenger: Show commit message" },
    },
  },

  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      require("git-worktree").setup()
      vim.keymap.set("n", "<leader>wl", function()
        require("telescope").extensions.git_worktree.git_worktrees()
      end, { desc = "List git worktrees" })
      vim.keymap.set("n", "<leader>wc", function()
        require("telescope").extensions.git_worktree.create_git_worktree()
      end, { desc = "Create git worktree" })
    end,
  },

  -- ========================================
  -- UI ENHANCEMENTS
  -- ========================================
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup {
        cmdline = {
          enabled = false,
        },
        lsp = {
          progress = {
            enabled = true,
          },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          signature = {
            auto_open = { enabled = false },
          },
        },
        messages = {
          enabled = false,
        },
        popupmenu = {
          enabled = true,
        },
      }
    end,
  },

  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require "alpha"
      local dashboard = require "alpha.themes.dashboard"

      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
        dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
        dashboard.button("SPC ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
        dashboard.button("SPC fg", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
        dashboard.button("SPC wr", "󰁯  > Restore Session", "<cmd>SessionRestore<CR>"),
        dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
      }

      alpha.setup(dashboard.opts)
      vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]
    end,
  },

  -- ========================================
  -- SESSION MANAGEMENT
  -- ========================================
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup {
        auto_restore_enabled = false,
        auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
      }

      vim.keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
      vim.keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session" })
    end,
  },

  -- ========================================
  -- CODE EDITING ENHANCEMENTS
  -- ========================================
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
    init = function()
      vim.g.VM_theme = "iceblue"
      vim.g.VM_mouse_mappings = 1
      vim.g.VM_verbose = 1

      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
        ["Skip Region"] = "<C-x>",
        ["Select All"] = "<Leader>A",
        ["Add Cursor Down"] = "<M-Down>",
        ["Add Cursor Up"] = "<M-Up>",
        ["Visual Cursors"] = "<Leader>v",
        ["Undo"] = "u",
        ["Redo"] = "<C-r>",
        ["Switch Mode"] = "<Tab>",
      }

      vim.g.VM_default_mappings = 0
      vim.g.VM_leader = "\\"
      vim.g.VM_custom_motions = {
        ["^"] = "0",
        ["$"] = "$",
      }
    end,
  },

  -- Mini.nvim modules
  { "echasnovski/mini.nvim", version = false },
  {
    "echasnovski/mini.comment",
    version = false,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("ts_context_commentstring").setup {
        enable_autocmd = false,
      }

      require("mini.comment").setup {
        options = {
          custom_commentstring = function()
            return require("ts_context_commentstring.internal").calculate_commentstring { key = "commentstring" }
              or vim.bo.commentstring
          end,
        },
      }
    end,
  },

  {
    "echasnovski/mini.surround",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      mappings = {
        add = "sa",
        delete = "ds",
        find = "sf",
        find_left = "sF",
        highlight = "sh",
        replace = "sr",
        update_n_lines = "sn",
        suffix_last = "l",
        suffix_next = "n",
      },
      n_lines = 20,
      respect_selection_type = false,
      search_method = "cover",
      silent = false,
    },
  },

  {
    "echasnovski/mini.trailspace",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local miniTrailspace = require "mini.trailspace"
      miniTrailspace.setup {
        only_in_normal_buffers = true,
      }
      vim.keymap.set("n", "<leader>cw", function()
        miniTrailspace.trim()
      end, { desc = "Erase Whitespace" })

      vim.api.nvim_create_autocmd("CursorMoved", {
        pattern = "*",
        callback = function()
          require("mini.trailspace").unhighlight()
        end,
      })
    end,
  },

  {
    "echasnovski/mini.splitjoin",
    config = function()
      local miniSplitJoin = require "mini.splitjoin"
      miniSplitJoin.setup {
        mappings = { toggle = "" },
      }
      vim.keymap.set({ "n", "x" }, "sj", function()
        miniSplitJoin.join()
      end, { desc = "Join arguments" })
      vim.keymap.set({ "n", "x" }, "sk", function()
        miniSplitJoin.split()
      end, { desc = "Split arguments" })
    end,
  },

  -- ========================================
  -- UTILITIES
  -- ========================================
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { focus = true },
    cmd = "Trouble",
    keys = {
      { "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace diagnostics" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document diagnostics" },
      { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "Quickfix list" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
    },
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup()
      vim.keymap.set("n", "]t", function()
        require("todo-comments").jump_next()
      end, { desc = "Next todo comment" })
      vim.keymap.set("n", "[t", function()
        require("todo-comments").jump_prev()
      end, { desc = "Previous todo comment" })
    end,
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
    },
  },

  -- ========================================
  -- HARPOON - FAST FILE NAVIGATION
  -- ========================================
  {
    "thePrimeagen/harpoon",
    enabled = true,
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local harpoon = require "harpoon"
      local conf = require("telescope.config").values

      harpoon:setup {
        global_settings = {
          save_on_toggle = true,
          save_on_change = true,
        },
      }

      --Harpoon Nav Interface
      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():add()
      end, { desc = "Harpoon add file" })
      vim.keymap.set("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      --Harpoon marked files
      vim.keymap.set("n", "<C-y>", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<C-i>", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<C-n>", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<C-s>", function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<C-S-P>", function()
        harpoon:list():prev()
      end)
      vim.keymap.set("n", "<C-S-N>", function()
        harpoon:list():next()
      end)
    end,
  },

  -- ========================================
  -- AVANTE - AI CODING ASSISTANT
  -- ========================================
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
      provider = "claude",
      auto_suggestions_provider = "claude",
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-3-5-sonnet-20241022",
          extra_request_body = {
            temperature = 0,
            max_tokens = 4096,
          },
        },
        gemini = {
          endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
          model = "gemini-2.0-flash-exp",
          extra_request_body = {
            temperature = 0,
            max_tokens = 4096,
          },
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
      },
      mappings = {
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
        },
      },
      hints = { enabled = true },
      windows = {
        position = "right",
        wrap = true,
        width = 30,
        sidebar_header = {
          enabled = true,
          align = "center",
          rounded = true,
        },
        input = {
          prefix = "> ",
          height = 8,
        },
        edit = {
          border = "rounded",
          start_insert = true,
        },
        ask = {
          floating = false,
          start_insert = true,
          border = "rounded",
          focus_on_apply = "ours",
        },
      },
      highlights = {
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
      diff = {
        autojump = true,
        list_opener = "copen",
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  -- ========================================
  -- SNACKS - MULTI-UTILITY PLUGIN
  -- ========================================
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      styles = {
        input = {
          keys = {
            n_esc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
            i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
          },
        },
      },
      input = {
        enabled = true,
      },
      quickfile = {
        enabled = true,
        exclude = { "latex" },
      },
      picker = {
        enabled = true,
        matchers = {
          frecency = true,
          cwd_bonus = false,
        },
        formatters = {
          file = {
            filename_first = false,
            filename_only = false,
            icon_width = 2,
          },
        },
        layout = {
          preset = "telescope",
          cycle = false,
        },
        layouts = {
          select = {
            preview = false,
            layout = {
              backdrop = false,
              width = 0.6,
              min_width = 80,
              height = 0.4,
              min_height = 10,
              box = "vertical",
              border = "rounded",
              title = "{title}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", width = 0.6, height = 0.4, border = "top" },
            },
          },
          telescope = {
            reverse = true,
            layout = {
              box = "horizontal",
              backdrop = false,
              width = 0.8,
              height = 0.9,
              border = "none",
              {
                box = "vertical",
                { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
                {
                  win = "input",
                  height = 1,
                  border = "rounded",
                  title = "{title} {live} {flags}",
                  title_pos = "center",
                },
              },
              {
                win = "preview",
                title = "{preview:Preview}",
                width = 0.5,
                border = "rounded",
                title_pos = "center",
              },
            },
          },
          ivy = {
            layout = {
              box = "vertical",
              backdrop = false,
              width = 0,
              height = 0.4,
              position = "bottom",
              border = "top",
              title = " {title} {live} {flags}",
              title_pos = "left",
              { win = "input", height = 1, border = "bottom" },
              {
                box = "horizontal",
                { win = "list", border = "none" },
                { win = "preview", title = "{preview}", width = 0.5, border = "left" },
              },
            },
          },
        },
      },
      image = {
        enabled = true,
        doc = {
          float = true,
          inline = false,
          max_width = 50,
          max_height = 30,
          wo = {
            wrap = false,
          },
        },
        convert = {
          notify = true,
          command = "magick",
        },
        img_dirs = {
          "img",
          "images",
          "assets",
          "static",
          "public",
          "media",
          "attachments",
          "Archives/All-Vault-Images/",
          "~/Library",
          "~/Downloads",
        },
      },
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
    keys = {
      { "<leader>lg", function() require("snacks").lazygit() end, desc = "Lazygit" },
      { "<leader>gl", function() require("snacks").lazygit.log() end, desc = "Lazygit Logs" },
      { "<leader>rN", function() require("snacks").rename.rename_file() end, desc = "Fast Rename Current File" },
      { "<leader>dB", function() require("snacks").bufdelete() end, desc = "Delete or Close Buffer  (Confirm)" },
      {
        "<leader>pf",
        function()
          require("snacks").picker.files {
            layout = "telescope",
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
            file_ignore_patterns = {
              "%.jpg",
              "%.jpeg",
              "%.png",
              "%.gif",
              "%.webp",
              "%.svg",
              "%.class",
              "%.o",
              "%.so",
              "%.zip",
              "%.tar",
              "%.gz",
              "node_modules",
              "%.DS_Store",
            },
          }
        end,
        desc = "Find Files (Snacks Picker)",
      },
      {
        "<leader>pc",
        function()
          require("snacks").picker.files { cwd = vim.fn.stdpath "config" }
        end,
        desc = "Find Config File",
      },
      { "<leader>ps", function() require("snacks").picker.grep() end, desc = "Grep word" },
      {
        "<leader>pws",
        function()
          require("snacks").picker.grep_word()
        end,
        desc = "Search Visual selection or Word",
        mode = { "n", "x" },
      },
      {
        "<leader>pk",
        function()
          require("snacks").picker.keymaps { layout = "ivy" }
        end,
        desc = "Search Keymaps (Snacks Picker)",
      },
      {
        "<leader>gbr",
        function()
          require("snacks").picker.git_branches { layout = "select" }
        end,
        desc = "Pick and Switch Git Branches",
      },
      {
        "<leader>th",
        function()
          require("snacks").picker.colorschemes { layout = "ivy" }
        end,
        desc = "Pick Color Schemes",
      },
      { "<leader>vh", function() require("snacks").picker.help() end, desc = "Help Pages" },
      {
        "<leader>pt",
        function()
          require("snacks").picker.todo_comments()
        end,
        desc = "Todo",
      },
      {
        "<leader>pT",
        function()
          require("snacks").picker.todo_comments { keywords = { "TODO", "FIX", "FIXME" } }
        end,
        desc = "Todo/Fix/Fixme",
      },
    },
  },

  -- ========================================
  -- WILDER - ENHANCED COMMAND-LINE
  -- ========================================
  {
    "gelguy/wilder.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "romgrk/fzy-lua-native",
    },
    config = function()
      local wilder = require "wilder"

      wilder.setup { modes = { ":", "/", "?" } }

      wilder.set_option(
        "pipeline",
        wilder.branch(
          wilder.cmdline_pipeline {
            fuzzy = 1,
            fuzzy_filter = wilder.lua_fzy_filter(),
          },
          wilder.vim_search_pipeline {
            fuzzy = 1,
          }
        )
      )

      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
          min_width = "20%",
          max_height = "15%",
          reverse = 0,
          highlighter = wilder.lua_fzy_highlighter(),
          highlights = {
            default = wilder.make_hl("WilderPopupMenu", "Pmenu", { { a = 1 }, { a = 1 }, { background = "#1E212B" } }),
            accent = wilder.make_hl(
              "WilderAccent",
              "Pmenu",
              { { a = 1 }, { a = 1 }, { foreground = "#58FFD6", background = "#1e1e2e" } }
            ),
          },
          border = "single",
        })
      )
    end,
  },

  -- ========================================
  -- INCLINE - FILENAME AT TOP-RIGHT
  -- ========================================
  {
    "b0o/incline.nvim",
    enabled = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local devicons = require "nvim-web-devicons"

      require("incline").setup {
        hide = {
          only_win = false,
        },
        render = function(props)
          local bufname = vim.api.nvim_buf_get_name(props.buf)
          local filename = vim.fn.fnamemodify(bufname, ":t")
          if filename == "" then
            filename = "[No Name]"
          end

          local ext = vim.fn.fnamemodify(bufname, ":e")
          local icon, icon_color = devicons.get_icon(filename, ext, { default = true })

          local modified = vim.bo[props.buf].modified

          return {
            { " ", icon, " ", guifg = icon_color },
            { filename, gui = modified and "bold" or "none" },
            modified and { " [+]", guifg = "#ff9e64" } or "",
            " ",
          }
        end,
      }
    end,
  },

  -- ========================================
  -- BUFFERLINE - VISUAL BUFFER TABS
  -- ========================================
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    opts = {
      options = {
        mode = "buffers",
        themable = true,
        numbers = "none",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = {
          icon = "▎",
          style = "icon",
        },
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match "error" and " " or " "
          return " " .. icon .. count
        end,
        custom_filter = function(buf_number, buf_numbers)
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
        separator_style = "slant",
        enforce_regular_tabs = false,
        always_show_bufferline = false,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        sort_by = "insert_after_current",
        close_icon = "",
        left_mouse_command = "buffer %d",
        middle_mouse_command = "bdelete! %d",
      },
      highlights = {
        buffer_selected = {
          bold = true,
          italic = false,
        },
        modified = {
          fg = "#ff9e64",
        },
        modified_visible = {
          fg = "#ff9e64",
        },
        modified_selected = {
          fg = "#ff9e64",
          bold = true,
        },
      },
    },
  },

  -- ========================================
  -- TAILWIND COLORIZER
  -- ========================================
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup {
        color_square_width = 2,
      }
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
    config = function()
      local nvchadcolorizer = require "colorizer"

      nvchadcolorizer.setup {
        user_default_options = {
          tailwind = true,
        },
        filetypes = { "html", "css", "javascript", "typescript", "jsx", "tsx", "vue", "svelte" },
      }

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        callback = function()
          vim.cmd "ColorizerAttachToBuffer"
        end,
      })
    end,
  },

  -- ========================================
  -- LUALINE - STATUSLINE
  -- ========================================
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lualine = require "lualine"
      local lazy_status = require "lazy.status"

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
        "mode",
        fmt = function(str)
          return " " .. str
        end,
      }

      local diff = {
        "diff",
        colored = true,
        symbols = { added = " ", modified = " ", removed = " " },
      }

      local filename = {
        "filename",
        file_status = true,
        path = 1,
        symbols = {
          modified = "[●]",
          readonly = "[🔒]",
          unnamed = "[No Name]",
          newfile = "[New]",
        },
        color = function()
          if vim.bo.modified then
            return { fg = "#ff9e64", gui = "bold" }
          end
          return nil
        end,
      }

      local branch = { "branch", icon = { "", color = { fg = "#A6D4DE" } }, "|" }

      lualine.setup {
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
              lazy_status.updates,
              cond = lazy_status.has_updates,
              color = { fg = "#ff9e64" },
            },
            { "filetype" },
          },
        },
      }
    end,
  },

  -- ========================================
  -- NVIM-UFO - BETTER FOLDING
  -- ========================================
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      require("ufo").setup {
        provider_selector = function(_, _, _)
          return { "treesitter", "indent" }
        end,
        open_fold_hl_timeout = 0,
      }

      vim.o.foldenable = true
      vim.o.foldcolumn = "0"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99

      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    end,
  },

  -- ========================================
  -- TYPESCRIPT-TOOLS - ENHANCED TS SUPPORT
  -- ========================================
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      local api = require "typescript-tools.api"
      require("typescript-tools").setup {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false

          local opts = { buffer = bufnr, silent = true }

          opts.desc = "Implement interface members"
          vim.keymap.set("n", "<leader>cm", function()
            vim.lsp.buf.code_action {
              apply = true,
              context = {
                only = { "source.fixAll.ts", "quickfix" },
                diagnostics = vim.diagnostic.get(bufnr),
              },
            }
          end, opts)

          opts.desc = "Add all missing imports"
          vim.keymap.set("n", "<leader>cA", function()
            vim.lsp.buf.code_action {
              apply = true,
              context = {
                only = { "source.addMissingImports.ts" },
                diagnostics = {},
              },
            }
          end, opts)
        end,
        settings = {
          separate_diagnostic_server = true,
          publish_diagnostic_on = "change",
          tsserver_path = nil,
          tsserver_max_memory = "auto",
          tsserver_locale = "en",
          complete_function_calls = false,
          include_completions_with_insert_text = true,
          code_lens = "off",
          disable_member_code_lens = true,
          expose_as_code_action = "all",
          jsx_close_tag = {
            enable = false,
            filetypes = { "javascriptreact", "typescriptreact" },
          },
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            importModuleSpecifierPreference = "non-relative",
            quotePreference = "double",
            includeCompletionsForModuleExports = true,
            includeCompletionsWithInsertText = true,
          },
        },
      }
    end,
  },

  -- ========================================
  -- VIM-MAXIMIZER - WINDOW MAXIMIZER
  -- ========================================
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
    },
  },

  -- ========================================
  -- SHOWKEYS - DISPLAY KEYPRESSES
  -- ========================================
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      maxkeys = 3,
      show_count = true,
      winopts = {
        focusable = false,
        relative = "editor",
        style = "minimal",
        border = "single",
        height = 1,
        row = 1,
        col = 0,
      },
    },
  },

  -- ========================================
  -- IMAGE SUPPORT - PASTE IMAGES
  -- ========================================
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
    opts = {
      default = {
        insert_mode_after_paste = true,
        url_encode_path = true,
        template = "$FILE_PATH",
        use_cursor_in_template = true,

        prompt_for_file_name = true,
        show_dir_path_in_prompt = true,

        use_absolute_path = false,
        relative_to_current_file = true,

        embed_image_as_base64 = false,
        max_base64_size = 10,

        dir_path = function()
          local cwd = vim.fn.getcwd()
          local vault_name = "sethVault"
          local vault_images_path = "Archives/All-Vault-Images/"

          if cwd:match(vault_name) then
            return vault_images_path
          else
            return "assets"
          end
        end,

        drag_and_drop = {
          enabled = true,
          insert_mode = true,
          copy_images = true,
          download_images = true,
        },
      },
    },
  },
}
