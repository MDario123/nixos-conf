{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      # LSPs
      gopls
      intelephense
      lua-language-server
      nil
      python312Packages.python-lsp-server
      ruff
      typescript-language-server
      vscode-langservers-extracted

      ## Unity
      csharp-ls

      # Formatter
      nixpkgs-fmt
      stylua
      prettierd
      gofumpt
      gotools

      # General dependencies
      wl-clipboard
      xclip
      ripgrep
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
      ${builtins.readFile ./plugin/term.lua}
    '';

    plugins = with pkgs.vimPlugins; [
      # UI
      nvim-web-devicons
      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = ''vim.cmd.colorscheme "catppuccin-mocha"'';
      }
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = builtins.readFile ./plugin/nvim-tree.lua;
      }
      {
        plugin = which-key-nvim;
        type = "lua";
        config = builtins.readFile ./plugin/which-key-nvim.lua;
      }
      {
        plugin = barbar-nvim;
        type = "lua";
        config = builtins.readFile ./plugin/barbar.lua;
      }
      {
        # https://github.com/nvim-lualine/lualine.nvim
        plugin = lualine-nvim;
        type = "lua";
        config = builtins.readFile ./plugin/lualine.lua;
      }
      {
        plugin = dressing-nvim;
        type = "lua";
        config = builtins.readFile ./plugin/dressing.lua;
      }
      # Utils
      {
        plugin = comment-nvim;
        type = "lua";
        config = builtins.readFile ./plugin/comment.lua;
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./plugin/telescope.lua;
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = builtins.readFile ./plugin/tree-sitter.lua;
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = builtins.readFile ./plugin/gitsigns.lua;
      }
      {
        plugin = vim-fugitive;
        type = "lua";
        config = builtins.readFile ./plugin/fugitive.lua;
      }
      # LSP related
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./plugin/lsp.lua;
      }
      {
        plugin = none-ls-nvim;
        type = "lua";
        config = builtins.readFile ./plugin/none-ls.lua;
      }

      # Completion
      luasnip
      friendly-snippets
      cmp_luasnip
      cmp-path
      cmp-buffer
      cmp-nvim-lsp
      cmp-nvim-lua
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./plugin/cmp.lua;
      }

      # AI completion
      {
        plugin = copilot-vim;
        type = "lua";
        config = builtins.readFile ./plugin/copilot.lua;
      }
    ];
  };
}
