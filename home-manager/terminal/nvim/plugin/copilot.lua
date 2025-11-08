vim.keymap.set("i", "<C-S-Space>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

vim.keymap.set("n", "<leader>cd", "<cmd>Copilot disable<CR>", {
  desc = "Disable Copilot",
})

vim.keymap.set("n", "<leader>ce", "<cmd>Copilot enable<CR>", {
  desc = "Enable Copilot",
})
