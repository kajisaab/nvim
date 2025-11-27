return{
    "mfussenegger/nvim-dap",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text", -- Show variable values as virtual text
        "jay-babu/mason-nvim-dap.nvim",    -- Auto-install DAP adapters
    },

    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- Setup mason-nvim-dap to auto-install debuggers
        require("mason-nvim-dap").setup({
            ensure_installed = {
                "python",    -- debugpy
                "codelldb",  -- C/C++/Rust debugger
                "delve",     -- Go debugger
            },
            automatic_installation = true,
            handlers = {},
        })

        -- Setup DAP UI
        require("dapui").setup()

        -- Setup virtual text for showing variable values
        require("nvim-dap-virtual-text").setup()

        -- Auto open/close DAP UI
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

        -- Python debugger configuration
        dap.adapters.python = {
            type = 'executable',
            command = 'python',
            args = { '-m', 'debugpy.adapter' },
        }

        dap.configurations.python = {
            {
                type = 'python',
                request = 'launch',
                name = "Launch file",
                program = "${file}",
                pythonPath = function()
                    return 'python'
                end,
            },
        }

        -- C/C++/Rust debugger configuration (using codelldb)
        dap.adapters.codelldb = {
            type = 'server',
            port = "${port}",
            executable = {
                command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
                args = {"--port", "${port}"},
            }
        }

        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
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
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
            },
        }

        -- Go debugger configuration (using delve)
        dap.adapters.delve = {
            type = 'server',
            port = '${port}',
            executable = {
                command = 'dlv',
                args = {'dap', '-l', '127.0.0.1:${port}'},
            }
        }

        dap.configurations.go = {
            {
                type = "delve",
                name = "Debug",
                request = "launch",
                program = "${file}"
            },
            {
                type = "delve",
                name = "Debug test",
                request = "launch",
                mode = "test",
                program = "${file}"
            },
            {
                type = "delve",
                name = "Debug test (go.mod)",
                request = "launch",
                mode = "test",
                program = "./${relativeFileDirname}"
            }
        }

        -- Keybindings
        vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
        vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue/Start debugging" })
        vim.keymap.set("n", "<Leader>dso", dap.step_over, { desc = "Step over" })
        vim.keymap.set("n", "<Leader>dsi", dap.step_into, { desc = "Step into" })
        vim.keymap.set("n", "<Leader>dsx", dap.step_out, { desc = "Step out" })
        vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" })
        vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run last" })
        vim.keymap.set("n", "<Leader>dt", dapui.toggle, { desc = "Toggle DAP UI" })
    end,
}
