if pcall(require, "codecompanion") then
  local config = {}
  config.strategies = {
    chat = {
      adapter = "copilot",
    },
    inline = {
      adapter = "copilot",
    },
  }

  local keymap_opts = { noremap = true, silent = true }
  vim.keymap.set("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", keymap_opts)
  vim.keymap.set("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", keymap_opts)
  vim.keymap.set("n", "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", keymap_opts)
  vim.keymap.set("v", "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", keymap_opts)
  vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", keymap_opts)

  -- Expand 'cc' into 'CodeCompanion' in the command line
  vim.cmd([[cab cc CodeCompanion]])

  require("codecompanion").setup(config)
end
