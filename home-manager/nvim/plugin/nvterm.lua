require("nvterm").setup()

vim.keymap.set({ "n", "t" }, "<A-i>", function()
  require("nvterm.terminal").toggle("float")
end, { desc = "Toggle floating term" })

vim.keymap.set({ "n", "t" }, "<A-h>", function()
  require("nvterm.terminal").toggle("horizontal")
end, { desc = "Toggle horizontal term" })

vim.keymap.set({ "n", "t" }, "<A-v>", function()
  require("nvterm.terminal").toggle("vertical")
end, { desc = "Toggle vertical term" })
