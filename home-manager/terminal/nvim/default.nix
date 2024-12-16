{ pkgs, ... }:

let
  codecompanion = pkgs.vimUtils.buildVimPlugin {
    name = "codecompanion";
    version = "10.7.0";
    src = pkgs.fetchFromGitHub {
      owner = "olimorris";
      repo = "codecompanion.nvim";
      rev = "9f19ade90dd916bc1f51731465be8fb50eecc12a";
      hash = "sha256-RAn7U3N9yxgHxugriMBLk5zZ8UhA8MYF2A1yONfl2Fk=";
    };
  };
in
{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      # LSPs
      lua-language-server
      nil
      python312Packages.python-lsp-server
      gopls
      intelephense
      typescript-language-server
      vscode-langservers-extracted

      # Formatter
      nixpkgs-fmt
      python312Packages.black
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
        config = ''require('which-key').setup()'';
      }
      {
        plugin = nvterm;
        type = "lua";
        config = builtins.readFile ./plugin/nvterm.lua;
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

      # Codecompanion for AI completion
      copilot-vim
      {
        plugin = codecompanion;
        type = "lua";
        config = builtins.readFile ./plugin/codecompanion.lua;
      }
    ];
  };
}
