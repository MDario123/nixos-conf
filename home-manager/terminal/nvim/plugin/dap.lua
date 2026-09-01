local dap = require("dap")
local ui = require("dapui")

local gdb_path = vim.fn.exepath("gdb")

if gdb_path ~= "" then
  dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
  }

  dap.configurations.c = {
    {
      name = "Launch",
      type = "gdb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      args = {}, -- provide arguments if needed
      cwd = "${workspaceFolder}",
      stopAtBeginningOfMainSubprogram = false,
    },
  }

  dap.configurations.cpp = dap.configurations.c
  dap.configurations.rust = dap.configurations.c
end

vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

-- Eval var under cursor
vim.keymap.set("n", "<space>?", function()
  require("dapui").eval(nil, { enter = true })
end)

vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F13>", dap.restart)

dap.listeners.before.attach.dapui_config = function()
  ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  ui.close()
end
