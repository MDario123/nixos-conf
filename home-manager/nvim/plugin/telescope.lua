vim.keymap.set("n", "<leader>fw", "<Cmd> Telescope live_grep <CR>", { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>ff", "<Cmd> Telescope find_files <CR>", { desc = "Telescope find files" })
vim.keymap.set(
  "n",
  "<leader>fz",
  "<Cmd> Telescope current_buffer_fuzzy_find <CR>",
  { desc = "Telescope find in current buffer" }
)
