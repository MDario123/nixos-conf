{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      # LSPs
      # lua-language-server
      # rnix-lsp

      # General dependencies
      # wl-clipboard
      # ripgrep
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
    '';

    plugins = with pkgs.vimPlugins; [
      {
        plugin = comment-nvim;
        type = "lua";
        config = "require(\"Comment\").setup()";
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./plugin/lsp.lua;
      }

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
        config = builtins.readFile ./plugin/which-key.lua;
      }
      # neodev-nvim
      nvim-cmp
      telescope-nvim
      telescope-fzf-native-nvim
      # cmp_luasnip
      # cmp-nvim-lsp
      # luasnip
      # friendly-snippets
      # lualine-nvim
      nvim-web-devicons
      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-lua
        p.tree-sitter-rust
        p.tree-sitter-cpp
      ]))
    ];

  };
}
