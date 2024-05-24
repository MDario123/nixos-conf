require("Comment").setup()

vim.keymap.set('n', '<Leader>/',
      function()
        require("Comment.api").toggle.linewise.current()
      end,
{ desc = 'Go to next buffer' })

vim.keymap.set('n', '<Leader>/',
"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
{ desc = 'Go to next buffer' })
