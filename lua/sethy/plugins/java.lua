return {
    'mfussenegger/nvim-jdtls',
    ft = { 'java' },
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      local jdtls = require('jdtls')
      local home = os.getenv('HOME')
    
      -- Workspace directory
      local workspace_dir = home .. '/.local/share/eclipse/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    
      local root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'})
      if root_dir == nil then return end
    
      local config = {
        cmd = { 'jdtls', '-data', workspace_dir },
        root_dir = root_dir,
        settings = { java = {} },
        init_options = { bundles = {} },
        on_attach = function(client, bufnr)
          -- Java-specific keybindings
          local opts = { buffer = bufnr, silent = true }

          -- Implement missing interface/abstract methods
          opts.desc = "Implement interface/abstract methods"
          vim.keymap.set("n", "<leader>cm", function()
            vim.lsp.buf.code_action({
              filter = function(action)
                return action.kind and (
                  action.kind:match("quickfix") or
                  action.kind:match("source") or
                  action.title:match("Implement") or
                  action.title:match("Override") or
                  action.title:match("Add unimplemented methods")
                )
              end,
              apply = true,
            })
          end, opts)

          -- Generate getters and setters
          opts.desc = "Generate getters/setters"
          vim.keymap.set("n", "<leader>cg", function()
            vim.lsp.buf.code_action({
              filter = function(action)
                return action.title:match("Generate Getter") or action.title:match("Generate Setter")
              end,
              apply = true,
            })
          end, opts)

          -- Generate constructor
          opts.desc = "Generate constructor"
          vim.keymap.set("n", "<leader>cc", function()
            vim.lsp.buf.code_action({
              filter = function(action)
                return action.title:match("Generate constructor")
              end,
              apply = true,
            })
          end, opts)
        end,
      }

      jdtls.start_or_attach(config)
    
      -- ✅ Insert this here so it's loaded with ft=java
      vim.api.nvim_create_autocmd("BufNewFile", {
        pattern = "*.java",
        callback = function()
          local filepath = vim.fn.expand("%:p")
          local filename = vim.fn.expand("%:t:r")
    
          local java_root = filepath:match("(.-)src[/\\]main[/\\]java[/\\]")
          if not java_root then return end
    
          local package_path = filepath:match("src[/\\]main[/\\]java[/\\](.-)[/\\][^/\\]+%.java$")
          if not package_path then return end
    
          local package_name = package_path:gsub("[/\\]", ".")
          local lines = {
            "package " .. package_name .. ";",
            "",
            "public class " .. filename .. " {",
            "    ",
            "}",
          }
    
          -- Only insert if buffer is empty
          if vim.api.nvim_buf_line_count(0) == 1 and vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == "" then
            vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
            vim.api.nvim_win_set_cursor(0, {4, 4}) -- Move inside the class body
          end
        end,
      })
    end
  } 