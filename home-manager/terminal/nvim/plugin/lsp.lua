local M = {}
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = vim.tbl_deep_extend("force", M.capabilities, require("cmp_nvim_lsp").default_capabilities())

-- Create a command `:Format` local to the LSP buffer
-- This will format the current buffer with the LSP's formatting capabilities
-- See `:help vim.lsp.buf.format` for more information
vim.api.nvim_create_user_command("Format", function(_)
  if not vim.lsp.buf.format then
    vim.notify("LSP format not available", vim.log.levels.WARN)
    return
  end
  vim.lsp.buf.format({ async = false })
end, { desc = "Format current buffer with LSP" })

vim.g.lsp_on_attach = function(event)
  -- NOTE: Remember that Lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
  end

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

  -- Find references for the word under your cursor.
  map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- Rename the variable under your cursor.
  --  Most Language Servers support renaming across files, etc.
  map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  -- Opens a popup that displays documentation about the word under your cursor
  --  See `:help K` for why this keymap.
  map("K", vim.lsp.buf.hover, "Hover Documentation")

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

  -- The following two autocommands are used to highlight references of the
  -- word under your cursor when your cursor rests there for a little while.
  --    See `:help CursorHold` for information about when this is executed
  --
  -- When you move your cursor, the highlights will be cleared (the second autocommand).
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client.server_capabilities.documentHighlightProvider then
    local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
      end,
    })
  end

  -- The following autocommand is used to enable inlay hints in your
  -- code, if the language server you are using supports them
  --
  -- This may be unwanted, since they displace some of your code
  if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    map("<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, "[T]oggle Inlay [H]ints")
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = vim.g.lsp_on_attach,
})

-- Common configuration for all language servers
vim.lsp.config("*", {
  capabilities = M.capabilities,
  root_markers = { ".git" },
})

-- Language server specific configurations

-- Lua
vim.lsp.config("lua_ls", {
  filetypes = { "lua" },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          [vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})
vim.lsp.enable("lua_ls")

-- Nix
vim.lsp.config("nil_ls", {
  filetypes = { "nix" },
  root_markers = { "flake.nix", "default.nix", ".git" },
})
vim.lsp.enable("nil_ls")

-- Rust
vim.lsp.config("rust_analyzer", {
  filetypes = { "rust" },
  root_markers = { "Cargo.toml" },
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
    },
  },
})
vim.lsp.enable("rust_analyzer")

-- Go
vim.lsp.config("gopls", {
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    completeUnimported = true,
    usePlaceholder = true,
    analyses = {
      unusedparams = true,
      fieldalignment = true,
      nilness = true,
    },
  },
})
vim.lsp.enable("gopls")

-- C/C++
vim.lsp.config("clangd", {
  filetypes = { "c", "cpp" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
  cmd = { "clangd", "--background-index", "--clang-tidy" },
})
vim.lsp.enable("clangd")

-- Python
vim.lsp.config("pylsp", {
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
})
vim.lsp.enable("pylsp")

vim.lsp.config("mypy", {
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
})
vim.lsp.enable("mypy")

vim.lsp.config("ruff", {
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
  settings = {
    logLevel = "debug",
  },
})
vim.lsp.enable("ruff")

-- TypeScript
vim.lsp.config("ts_ls", {
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
})
vim.lsp.enable("ts_ls")

-- CSS
vim.lsp.config("cssls", {
  filetypes = { "css", "scss", "less" },
})
