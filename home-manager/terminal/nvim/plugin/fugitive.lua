local function map(mode, l, r, desc)
  local opts = {}
  opts.desc = desc
  vim.keymap.set(mode, l, r, opts)
end

map("n", "<leader>s", "<Cmd> G <CR>", "Git [s]tatus")
map("n", "<leader>hc", "<Cmd> G commit <CR>", "Git [c]ommit")
vim.keymap.set("n", "<leader>hP", "<Cmd> G! push <CR>", { desc = "Git [P]ush", silent = true })

-- Log
map("n", "<leader>hl", "<Cmd> G log -n 30 <CR>", "Git [l]og")
map("n", "<leader>hlf", "<Cmd> G log <CR>", "Git [l]og [f]ull")
-- Graph
map("n", "<leader>hlg", "<Cmd> G log --graph -n 30 <CR>", "Git [l]og [g]raph")
map("n", "<leader>hlgf", "<Cmd> G log --graph <CR>", "Git [l]og [g]raph [f]ull")
-- Oneline
map("n", "<leader>hlo", "<Cmd> G log --oneline -n 30 <CR>", "Git [l]og [o]neline")
map("n", "<leader>hlof", "<Cmd> G log --oneline <CR>", "Git [l]og [o]neline [f]ull")
-- Graph Oneline
map("n", "<leader>hlgo", "<Cmd> G log --graph --oneline -n 30 <CR>", "Git [l]og [g]raph [o]neline")
map("n", "<leader>hlgof", "<Cmd> G log --graph --oneline <CR>", "Git [l]og [g]raph [o]neline [f]ull")
