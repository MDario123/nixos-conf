local function map(mode, l, r, desc)
  local opts = {}
  opts.desc = desc
  vim.keymap.set(mode, l, r, opts)
end

map("n", "<leader>s", "<Cmd> G <CR>", "Git [s]tatus")
map("n", "<leader>gc", "<Cmd> G commit <CR>", "Git [c]ommit")
vim.keymap.set("n", "<leader>gP", "<Cmd> G! push <CR>", { desc = "Git [P]ush", silent = true })

-- Log
map("n", "<leader>gl", "<Cmd> G log -n 30 <CR>", "Git [l]og")
map("n", "<leader>glf", "<Cmd> G log <CR>", "Git [l]og [f]ull")
-- Graph
map("n", "<leader>glg", "<Cmd> G log --graph -n 30 <CR>", "Git [l]og [g]raph")
map("n", "<leader>glgf", "<Cmd> G log --graph <CR>", "Git [l]og [g]raph [f]ull")
-- Oneline
map("n", "<leader>glo", "<Cmd> G log --oneline -n 30 <CR>", "Git [l]og [o]neline")
map("n", "<leader>glof", "<Cmd> G log --oneline <CR>", "Git [l]og [o]neline [f]ull")
-- Graph Oneline
map("n", "<leader>glgo", "<Cmd> G log --graph --oneline -n 30 <CR>", "Git [l]og [g]raph [o]neline")
map("n", "<leader>glgof", "<Cmd> G log --graph --oneline <CR>", "Git [l]og [g]raph [o]neline [f]ull")
