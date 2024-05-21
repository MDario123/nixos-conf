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

    # plugins = with pkgs.vimPlugins; [
    #   {
    #     plugin = comment-nvim;
    #     type = "lua";
    #     config = "require(\"Comment\").setup()";
    #   }
    #   {
    #     plugin = nvim-lspconfig;
    #     type = "lua";
    #     config = builtins.readFile ./plugin/lsp.lua;
    #   }
    #   neodev-nvim
    #   nvim-cmp
    #   telescope-nvim
    #   telescope-fzf-native-nvim
    #   cmp_luasnip
    #   cmp-nvim-lsp
    #   luasnip
    #   friendly-snippets
    #   lualine-nvim
    #   # nvim-web-icons
    #   (nvim-treesitter.withPlugins (p: [
    #     p.tree-sitter-nix
    #     p.tree-sitter-lua
    #     p.tree-sitter-rust
    #     p.tree-sitter-cpp
    #   ]))
    # ];
  };
}
