local api = require("nvim-tree.api")

local function opts(desc)
  return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

-- custom mappings
vim.keymap.set("n", "<C-n>", api.tree.toggle, opts("Toggle file tree"))

require("nvim-tree").setup({
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  -- filters = {
  --   dotfiles = true,
  -- },
})
