local term_buffers = {}

local function toggle_term(term_buffer_name, create_cmd)
  local term_buffer = term_buffers[term_buffer_name]

  if term_buffer == nil or vim.fn.bufexists(term_buffer) == 0 then
    -- If the buffer doesn't exist, create a new terminal
    vim.cmd(create_cmd .. "+term")
    term_buffer = vim.fn.bufnr()
    term_buffers[term_buffer_name] = term_buffer
    vim.api.nvim_set_option_value("buflisted", false, { buf = term_buffer })
    vim.cmd("startinsert")
    return
  else
    -- If the buffer exists, check if it's already open in a window
    local term_window = vim.fn.bufwinnr(term_buffer)
    -- If it's open, close it
    if term_window > 0 then
      vim.cmd.close({ count = term_window })
      -- If it's not open, open it in a new window
    else
      vim.cmd(create_cmd .. "+buffer" .. term_buffer)
      vim.cmd("startinsert")
    end
  end
end

-- Open a new terminal in a horizontal split
local function toggle_hterm()
  return toggle_term("hterm", "botright split")
end

-- Open a new terminal in a vertical split
local function toggle_vterm()
  return toggle_term("vterm", "botright vsplit")
end

vim.keymap.set({ "n", "t" }, "<A-h>", toggle_hterm, { desc = "Open new horizontal terminal" })
vim.keymap.set({ "n", "t" }, "<A-v>", toggle_vterm, { desc = "Open new vertical terminal" })
