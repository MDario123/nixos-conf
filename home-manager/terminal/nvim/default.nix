{ pkgs, ... }:

let
  codecompanion = pkgs.vimUtils.buildVimPlugin {
    name = "codecompanion";
    version = "0.5.2";
    src = pkgs.fetchFromGitHub {
      owner = "olimorris";
      repo = "codecompanion.nvim";
      rev = "9f63ae8012dce6c811238083b94620dd3d1d4893";
      hash = "sha256-wB35K0HdOk+389ZhDJb/iZtE7hkyWUblJPuwD0f+Rxo=";
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
      {
        plugin = codecompanion;
        type = "lua";
        config = builtins.readFile ./plugin/codecompanion.lua;
      }
    ];
  };
}
