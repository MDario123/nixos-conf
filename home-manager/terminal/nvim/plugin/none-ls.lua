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
    -- PHP
    null_ls.builtins.formatting.pint,
    -- QML
    null_ls.builtins.formatting.qmlformat,
    -- Web (HTML, CSS, Javascript, ...)
    null_ls.builtins.formatting.prettierd,
  },
})
