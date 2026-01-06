require("barbar").setup()

-- Change current buffer
vim.keymap.set("n", "<Tab>", "<Cmd>BufferNext<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", { desc = "Go to previous buffer" })

-- Close current buffer
vim.keymap.set("n", "<Leader>x", "<Cmd>BufferClose<CR>", { desc = "Close current buffer" })

-- Move buffer position
vim.keymap.set("n", "<Leader>bl", "<Cmd>BufferMoveNext<CR>", { desc = "Move buffer right" })
vim.keymap.set("n", "<Leader>bh", "<Cmd>BufferMovePrev<CR>", { desc = "Move buffer left" })

-- Order buffers by directory
vim.keymap.set("n", "<Leader>bd", "<Cmd>BufferOrderByDirectory<CR>", { desc = "Order buffers by directory" })
