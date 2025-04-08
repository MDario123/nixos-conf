local term_buffers = {}

local function toggle_term(term_buffer_name, create_cmd, resume_cmd)
  local term_buffer = term_buffers[term_buffer_name]

  -- Buffer has been deleted, reset the buffer number
  if term_buffer ~= nil and vim.fn.bufexists(term_buffer) == 0 then
    term_buffers[term_buffer_name] = nil
    term_buffer = nil
  end

  if term_buffer == nil then
    vim.cmd(create_cmd)
    term_buffer = vim.fn.bufnr()
    term_buffers[term_buffer_name] = term_buffer
    vim.api.nvim_set_option_value("buflisted", false, { buf = term_buffer })
    vim.cmd("startinsert")
    return
  else
    local term_window = vim.fn.bufwinnr(term_buffer)
    if term_window > 0 then
      vim.cmd.close({ count = term_window })
    else
      vim.cmd(resume_cmd .. term_buffer)
      vim.cmd("startinsert")
    end
  end
end

-- Open a new terminal in a horizontal split
local function toggle_hterm()
  return toggle_term("hterm", "botright split +term", "botright split +buffer")
end

-- Open a new terminal in a vertical split
local function toggle_vterm()
  return toggle_term("vterm", "botright vsplit +term", "botright vsplit +buffer")
end

vim.keymap.set({ "n", "t" }, "<A-h>", toggle_hterm, { desc = "Open new horizontal terminal" })
vim.keymap.set({ "n", "t" }, "<A-v>", toggle_vterm, { desc = "Open new vertical terminal" })
