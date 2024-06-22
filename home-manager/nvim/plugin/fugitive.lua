local function map(mode, l, r, desc)
  local opts = {}
  opts.desc = desc
  vim.keymap.set(mode, l, r, opts)
end

map("n", "<leader>s", "<Cmd> G <CR>", "Git [s]tatus")
map("n", "<leader>hc", "<Cmd> G commit <CR>", "Git [c]ommit")
map("n", "<leader>hp", "<Cmd> G push <CR>", "Git [p]ush")
