local dap = require("dap")
local ui = require("dapui")

require("dapui").setup()

local gdb_path = vim.fn.exepath("gdb")

if gdb_path ~= "" then
  dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
  }

  local function pick_file(callback, opts)
    local finders = require("telescope.finders")
    local pickers = require("telescope.pickers")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local NONE = "[NONE]"

    opts = opts or {}
    -- Prompt to display in the Telescope window. Default is "Select file".
    local prompt = opts.prompt or "Select file"
    -- Possible filetypes: "f" for regular files, "d" for directories, "l" for symlinks, "x" for executables, etc.
    local file_type = opts.file_type or "f"
    -- If true, ignore files in .gitignore and other VCS ignore files. If false, include them.
    local ignore_vcs = opts.ignore_vcs or false
    local include_none = opts.include_none or false

    return coroutine.create(function(dap_run_co)
      local cmd = { "fd", "--type", file_type, "--hidden" }
      if not ignore_vcs then
        vim.list_extend(cmd, { "--no-ignore-vcs" })
      end

      local results = vim.fn.systemlist(cmd)

      if include_none then
        table.insert(results, 1, NONE)
      end

      pickers
        .new({}, {
          prompt_title = prompt,
          finder = finders.new_table({ results = results }),
          sorter = conf.file_sorter({}),
          previewer = false,
          attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
              local entry = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              local path = entry and entry[1]
              if path == NONE then
                path = nil
              end
              coroutine.resume(dap_run_co, callback(path))
            end)
            return true
          end,
        })
        :find()
    end)
  end

  dap.configurations.c = {
    {
      name = "Launch",
      type = "gdb",
      request = "launch",
      cwd = "${workspaceFolder}",
      program = function()
        return pick_file(function(path)
          return path
        end, { prompt = "Select executable", file_type = "x", ignore_vcs = false })
      end,
      stopAtBeginningOfMainSubprogram = true,
    },
    {
      name = "Select and attach to process",
      type = "gdb",
      request = "attach",
      program = "${command:pickFile}",
      pid = function()
        local name = vim.fn.input("Executable name (filter): ")
        return require("dap.utils").pick_process({ filter = name })
      end,
      cwd = "${workspaceFolder}",
    },
    {
      name = "Attach to gdbserver :1234",
      type = "gdb",
      request = "attach",
      target = "localhost:1234",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
    },
  }

  dap.configurations.cpp = dap.configurations.c
  dap.configurations.rust = dap.configurations.c
end

vim.keymap.set("n", "<space>do", ui.open)
vim.keymap.set("n", "<space>dc", ui.close)
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
vim.keymap.set("n", "<F12>", dap.restart)

dap.listeners.before.attach.dapui_config = function()
  ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  ui.open()
end
