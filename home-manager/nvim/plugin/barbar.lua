require('barbar').setup()

-- Change current buffer
vim.keymap.set('n', '<Tab>', '<Cmd>BufferNext<CR>', { desc = 'Go to next buffer' })
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', { desc = 'Go to previous buffer' })

-- Close current buffer
vim.keymap.set('n', '<Leader>x', '<Cmd>BufferClose<CR>', { desc = 'Close current buffer' })
