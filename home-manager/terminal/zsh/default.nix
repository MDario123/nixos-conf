{ config, lib, pkgs, ... }:

{
  home.sessionVariables = {
    SHELL = "$(which zsh)";
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    # historySubstringSearch.enable = true;

    shellAliases = {
      nixos-update = "sudo nixos-rebuild switch --flake '${config.home.homeDirectory}/NixOS#mdario'";
      nixos-update-boot = "sudo nixos-rebuild boot --flake '${config.home.homeDirectory}/NixOS#mdario'";
      nixos-fully-collect-garbage = "sudo nix-collect-garbage -d && nixos-update-boot";
      home-manager-update = "home-manager switch --flake '${config.home.homeDirectory}/NixOS#mdario'";
      nd = "nix develop";
    };

    plugins = [
      {
        # will source you-should-use.plugin.zsh
        name = "you-should-use";
        src = pkgs.fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-you-should-use";
          rev = "1.8.0";
          sha256 = "sha256-fJX748lwVP1+GF/aIl1J3c6XAy/AtYCpEHsP8weUNo0=";
        };
      }
      {
        name = "cpd-zsh-completion";
        src = ./plugins;
        file = "_cpd";
      }
    ];
    oh-my-zsh = {
      enable = true;
      theme = "awesomepanda";
      plugins = [
        "sudo"
        "git"
      ];
    };
  };
}
