vim.keymap.set("n", "<leader>fw", "<Cmd> Telescope live_grep <CR>", { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>ff", "<Cmd> Telescope find_files <CR>", { desc = "Telescope [f]ind [f]iles" })
vim.keymap.set("n", "<leader>fh", "<Cmd> Telescope help_tags <CR>", { desc = "Telescope [f]ind [h]elp tags" })
vim.keymap.set("n", "<leader>fg", "<Cmd> Telescope git_status <CR>", { desc = "Telescope [f]ind [g]it status" })
vim.keymap.set(
  "n",
  "<leader>fz",
  "<Cmd> Telescope current_buffer_fuzzy_find <CR>",
  { desc = "Telescope find in current buffer" }
)
