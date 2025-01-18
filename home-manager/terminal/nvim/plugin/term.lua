local vterm_buffer = 0

-- Open a new terminal in a vertical split
local function toggle_vterm()
  -- Buffer has been deleted, reset the buffer number
  if vterm_buffer ~= 0 then
    if vim.fn.bufexists(vterm_buffer) == 0 then
      vterm_buffer = 0
    end
  end

  if vterm_buffer == 0 then
    vim.cmd("vsplit +term")
    vterm_buffer = vim.fn.bufnr()
    vim.api.nvim_set_option_value("buflisted", false, { buf = vterm_buffer })
    vim.cmd("startinsert")
    return
  else
    local vterm_window = vim.fn.bufwinnr(vterm_buffer)
    if vterm_window > 0 then
      vim.cmd.close({ count = vterm_window })
    else
      vim.cmd("vsplit +buffer" .. vterm_buffer)
      vim.cmd("startinsert")
    end
  end
end

vim.keymap.set({ "n", "t" }, "<A-v>", toggle_vterm, { desc = "Open new vertical terminal" })
