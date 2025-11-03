require("gitsigns").setup({
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, l, r, desc)
      local opts = {}
      opts.desc = desc
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Movement
    map("n", "<leader>gk", gitsigns.prev_hunk, "Go to previous change")
    map("n", "<leader>gj", gitsigns.next_hunk, "Go to next change")
    -- Staging actions
    map("n", "<leader>gs", gitsigns.stage_hunk, "Git [s]tage hunk")
    map("v", "<leader>gs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Git [s]tage hunk")

    map("n", "<leader>gr", gitsigns.reset_hunk, "Git [r]eset hunk")
    map("v", "<leader>gr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Git [r]eset gunk")

    map("n", "<leader>gu", gitsigns.undo_stage_hunk, "Git [u]ndo stage hunk")
    map("n", "<leader>gp", gitsigns.preview_hunk, "Git [p]review hunk")

    map("n", "<leader>gS", gitsigns.stage_buffer, "Git [S]tage buffer")
    map("n", "<leader>gR", gitsigns.reset_buffer, "Git [R]eset buffer")
  end,
})
