local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local null_ls = require("null-ls")

require("null-ls").setup({
  -- you can reuse a shared lspconfig on_attach callback here
  sources = {
    -- Go
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.golines,
    -- C++
    null_ls.builtins.formatting.clang_format,
    -- Nix
    null_ls.builtins.formatting.nixpkgs_fmt,
    -- Lua
    null_ls.builtins.formatting.stylua.with({
      extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    }),
    -- Python
    null_ls.builtins.formatting.black,
    -- QML
    null_ls.builtins.formatting.qmlformat,
  },

  on_attach = function(client, bufnr)
    if client.name == "null-ls" and client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})
