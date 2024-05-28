local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

local M = {}
M.capabilities = vim.lsp.protocol.make_client_capabilities()

lspconfig.lua_ls.setup {
  -- on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

lspconfig.nil_ls.setup {
  -- on_attach = on_attach,
  capabilities = M.capabilities,
}

lspconfig.rust_analyzer.setup {
  -- on_attach = on_attach,
  capabilities = M.capabilities,
  filetypes = { "rust" },
  root_dir = util.root_pattern("Cargo.toml"),
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
}

lspconfig.gopls.setup {
  -- on_attach = on_attach,
  capabilities = M.capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    completeUnimported = true,
    usePlaceholder = true,
    analyses = {
      unusedparams = true,
      fieldalignment = true,
      nilness = true,
    },
  },
}

lspconfig.clangd.setup {
  -- on_attach = function(client, bufnr)
  --   client.server_capabilities.signatureHelpProvider = false
  --   on_attach(client, bufnr)
  -- end,
  capabilities = M.capabilities,
}

lspconfig.pylsp.setup {
  -- on_attach = on_attach,
  capabilities = M.capabilities,
}
