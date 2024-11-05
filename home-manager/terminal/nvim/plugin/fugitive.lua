local function map(mode, l, r, desc)
  local opts = {}
  opts.desc = desc
  vim.keymap.set(mode, l, r, opts)
end

map("n", "<leader>s", "<Cmd> G <CR>", "Git [s]tatus")
map("n", "<leader>hc", "<Cmd> G commit <CR>", "Git [c]ommit")
vim.keymap.set("n", "<leader>hP", "<Cmd> G! push <CR>", { desc = "Git [P]ush", silent = true })
