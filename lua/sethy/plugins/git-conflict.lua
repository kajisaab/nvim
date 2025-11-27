return {
  'akinsho/git-conflict.nvim',
  version = "*",
  config = function()
    require('git-conflict').setup({
      default_mappings = false, -- We'll set custom mappings
      default_commands = true,
      disable_diagnostics = false,
      list_opener = 'Trouble quickfix', -- Open conflicts in Trouble for better UX
      highlights = {
        incoming = 'DiffAdd',
        current = 'DiffText',
      }
    })

    -- Easy keymaps for git conflict resolution (simpler shortcuts)
    -- Use co (conflict ours), ct (conflict theirs), etc.
    vim.keymap.set('n', 'co', '<cmd>GitConflictChooseOurs<cr>', { desc = '[C]onflict: Choose [O]urs (Current)' })
    vim.keymap.set('n', 'ct', '<cmd>GitConflictChooseTheirs<cr>', { desc = '[C]onflict: Choose [T]heirs (Incoming)' })
    vim.keymap.set('n', 'cb', '<cmd>GitConflictChooseBoth<cr>', { desc = '[C]onflict: Choose [B]oth' })
    vim.keymap.set('n', 'c0', '<cmd>GitConflictChooseNone<cr>', { desc = '[C]onflict: Choose [N]one' })
    vim.keymap.set('n', ']x', '<cmd>GitConflictNextConflict<cr>', { desc = 'Next Conflict' })
    vim.keymap.set('n', '[x', '<cmd>GitConflictPrevConflict<cr>', { desc = 'Previous Conflict' })
    vim.keymap.set('n', '<leader>cl', '<cmd>GitConflictListQf<cr>', { desc = 'List All Conflicts' })

    -- Also keep the leader-based keymaps for discoverability
    vim.keymap.set('n', '<leader>gco', '<cmd>GitConflictChooseOurs<cr>', { desc = 'Git Conflict: Choose Ours' })
    vim.keymap.set('n', '<leader>gct', '<cmd>GitConflictChooseTheirs<cr>', { desc = 'Git Conflict: Choose Theirs' })
    vim.keymap.set('n', '<leader>gcb', '<cmd>GitConflictChooseBoth<cr>', { desc = 'Git Conflict: Choose Both' })
    vim.keymap.set('n', '<leader>gc0', '<cmd>GitConflictChooseNone<cr>', { desc = 'Git Conflict: Choose None' })
    vim.keymap.set('n', '<leader>gcl', '<cmd>GitConflictListQf<cr>', { desc = 'Git Conflict: List All' })
  end
}