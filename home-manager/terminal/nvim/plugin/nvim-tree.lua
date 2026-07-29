require("nvim-tree").setup({
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
})

local function opts(desc)
  return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

-- custom mappings
vim.keymap.set("n", "<C-n>", require("nvim-tree.api").tree.toggle, opts("Toggle file tree"))
