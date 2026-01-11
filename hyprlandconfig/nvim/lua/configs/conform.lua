-- Define configuration options for formatting with conform.nvim
local options = {
  -- Set formatters for each filetype
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    html = { "prettierd" },
    css = { "prettierd" },
    json = { "prettierd" },
    markdown = { "prettierd" },
    yaml = { "prettierd" },
    go = { "gofmt", "goimports" },
    java = { "google-java-format" },
    rust = { "rustfmt" },
    -- python = { "prettierd" },
  },

  -- Format on save settings with conditional logic
  format_on_save = function(bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local filetype = vim.bo[bufnr].filetype

    -- Check if prettier config exists for JavaScript files
    if filetype == "javascript" or filetype == "javascriptreact" then
      local root = vim.fs.dirname(bufname)
      local prettier_configs = {
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.yml",
        ".prettierrc.yaml",
        ".prettierrc.js",
        ".prettierrc.cjs",
        "prettier.config.js",
        "prettier.config.cjs",
      }

      -- Search for prettier config in current and parent directories
      local found_config = false
      for _, config in ipairs(prettier_configs) do
        if vim.fn.findfile(config, root .. ";") ~= "" then
          found_config = true
          break
        end
      end

      -- Check package.json for prettier config
      local package_json = vim.fn.findfile("package.json", root .. ";")
      if package_json ~= "" then
        local ok, data = pcall(vim.fn.json_decode, vim.fn.readfile(package_json))
        if ok and data.prettier then
          found_config = true
        end
      end

      -- Only format if prettier config found
      if not found_config then
        return nil
      end
    end

    -- Format all other supported languages automatically
    return {
      timeout_ms = 500,
      lsp_fallback = true,
    }
  end,
}

-- Return the options table to be used by conform.nvim
return options
