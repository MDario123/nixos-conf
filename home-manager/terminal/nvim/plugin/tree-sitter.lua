require("nvim-treesitter.install").prefer_git = true

require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})

vim.treesitter.query.set("python", "injections", [[
(
(string_content) @injection.content
(#match? @injection.content "^[ \n]*--[ \n]*sql")
(#set! injection.language "sql")
)
]])

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldminlines = 10
vim.wo.foldenable = false
