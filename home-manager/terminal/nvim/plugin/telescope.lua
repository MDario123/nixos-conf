require("telescope").setup({
  defaults = {
    layout_strategy = "vertical",
  },
})

local function map(bind, cmd, desc)
  vim.keymap.set("n", "<leader>" .. bind, "<Cmd>Telescope " .. cmd .. "<CR>", { desc = desc })
end

-- Telescope file-related commands
map("ff", "find_files", "Telescope [f]ind [f]iles")
map("fb", "buffers", "Telescope [f]ind [b]uffers")
map("fw", "live_grep", "Telescope live grep")
map("fz", "current_buffer_fuzzy_find", "Telescope find in current buffer")

-- Telescope Git-related commands
map("fg", "git_status", "Telescope [f]ind [g]it status")
map("fB", "git_branches", "Telescope [f]ind [B]ranches")

-- Telescope LSP-related commands
map("fr", "lsp_references", "Telescope [f]ind [r]eferences")
map("fs", "lsp_document_symbols", "Telescope [f]ind [s]ymbols")
map("fi", "lsp_implementations", "Telescope [f]ind [i]mplementations")

-- Telescope miscellaneous commands
map("fh", "help_tags", "Telescope [f]ind [h]elp tags")
map("fc", "commands", "Telescope [f]ind [c]ommands")
map("ft", "treesitter", "Telescope [f]ind [t]reesitter")
