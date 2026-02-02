vim.keymap.set("i", ";f", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})

vim.keymap.set("i", ";w", "<Plug>(copilot-accept-word)", {
  desc = "Accept Copilot Word",
})

vim.keymap.set("i", ";l", "<Plug>(copilot-accept-line)", {
  desc = "Accept Copilot Line",
})

vim.keymap.set("n", "<leader>cd", "<cmd>Copilot disable<CR>", {
  desc = "Disable Copilot",
})

vim.keymap.set("n", "<leader>ce", "<cmd>Copilot enable<CR>", {
  desc = "Enable Copilot",
})

-- Config
vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = {
  ["*"] = false,
}
