vim.api.nvim_create_autocmd("FileType", {
  callback = function(event)
    local parsers = require("nvim-treesitter.parsers")
    if not parsers[event.match] then
      return
    end

    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo[0][0].foldmethod = "expr"
    vim.wo[0][0].foldminlines = 10
    vim.wo[0][0].foldenable = false
  end,
})

vim.treesitter.query.set(
  "python",
  "injections",
  [[
(
(string_content) @injection.content
(#match? @injection.content "^[ \n]*--[ \n]*sql")
(#set! injection.language "sql")
)
]]
)
