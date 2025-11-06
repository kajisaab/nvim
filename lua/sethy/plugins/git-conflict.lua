return {
  'akinsho/git-conflict.nvim',
  version = "*",
  config = function()
    require('git-conflict').setup({
      default_mappings = true, -- disable buffer local mapping created by this plugin
      default_commands = true, -- disable commands created by this plugin
      disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
      list_opener = 'copen', -- command or function to open the conflicts list
      highlights = { -- They must have background color, otherwise the default color will be used
        incoming = 'DiffAdd',
        current = 'DiffText',
      }
    })

    -- Keymaps for git conflict resolution
    vim.keymap.set('n', '<leader>gco', '<cmd>GitConflictChooseOurs<cr>', { desc = 'Choose Ours (Current Branch)' })
    vim.keymap.set('n', '<leader>gct', '<cmd>GitConflictChooseTheirs<cr>', { desc = 'Choose Theirs (Incoming Branch)' })
    vim.keymap.set('n', '<leader>gcb', '<cmd>GitConflictChooseBoth<cr>', { desc = 'Choose Both' })
    vim.keymap.set('n', '<leader>gc0', '<cmd>GitConflictChooseNone<cr>', { desc = 'Choose None' })
    vim.keymap.set('n', '<leader>gcn', '<cmd>GitConflictNextConflict<cr>', { desc = 'Next Conflict' })
    vim.keymap.set('n', '<leader>gcp', '<cmd>GitConflictPrevConflict<cr>', { desc = 'Previous Conflict' })
    vim.keymap.set('n', '<leader>gcl', '<cmd>GitConflictListQf<cr>', { desc = 'List Conflicts in Quickfix' })
  end
}