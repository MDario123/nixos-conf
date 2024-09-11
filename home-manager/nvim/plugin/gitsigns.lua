require("gitsigns").setup({
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, l, r, desc)
      local opts = {}
      opts.desc = desc
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Actions
    map("n", "<leader>hs", gitsigns.stage_hunk, "Git [s]tage hunk")
    map("v", "<leader>hs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Git [s]tage hunk")

    map("n", "<leader>hr", gitsigns.reset_hunk, "Git [r]eset hunk")
    map("v", "<leader>hr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Git [r]eset hunk")

    map("n", "<leader>hu", gitsigns.undo_stage_hunk, "Git [u]ndo stage hunk")
    map("n", "<leader>hp", gitsigns.preview_hunk, "Git [p]review hunk")

    map("n", "<leader>hS", gitsigns.stage_buffer, "Git [S]tage buffer")
    map("n", "<leader>hR", gitsigns.reset_buffer, "Git [R]eset buffer")
  end,
})
