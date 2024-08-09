{ config, pkgs, ... }:

let
  refact-neovim = pkgs.vimUtils.buildVimPlugin {
    name = "refact-neovim";
    # src = /home/mdario/Documents/Projects/refact/refact-neovim;
    # version = "0.1.1";
    src = pkgs.fetchFromGitHub {
      owner = "MDario123";
      repo = "refact-neovim";
      rev = "605a861f5a1ab8a17e1ad8e28026c874a461483a";
      hash = "sha256-slxhP//8x3ToI2x2t6bIh95yHIApDk8NVYqMPaGK+2s=";
    };
  };
  refact-lsp = pkgs.rust.packages.stable.rustPlatform.buildRustPackage {
    name = "refact-lsp";
    src = pkgs.fetchFromGitHub {
      owner = "MDario123";
      repo = "refact-lsp";
      rev = "dfd4b60b3fb806addd4d05fb9494e6ca880ae54d";
      hash = "sha256-rka7x94OobGob1L27h8BqbUKBRmyDpSzWb/Q344z7ik=";
    };

    cargoHash = "sha256-PtYdCnz1OwhOfROuoKUc5DXD4ghVIVjVQjTFU5r7wjU=";

    nativeBuildInputs = with pkgs; [
      pkg-config
      openssl
      protobuf

      rustc
      cargo
      gcc
    ];

    buildInputs = with pkgs; [
      pkg-config
      openssl
    ];
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

      # AI assistant
      refact-lsp

      # Formatter
      nixpkgs-fmt
      python312Packages.black
      stylua
      prettierd
      gofumpt
      gotools

      # General dependencies
      wl-clipboard
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

      # refact.ai for completion
      {
        plugin = refact-neovim;
        type = "lua";
        config = builtins.readFile ./plugin/refact-neovim.lua;
      }
    ];
  };
}
