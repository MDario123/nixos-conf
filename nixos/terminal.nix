{ config, lib, pkgs, ... }: 

{
  programs.starship = {
    enable = true;
    settings = {
      format = "$character";
      right_format = "$all";
      character = {
        success_symbol = "[=>>](bold green)";
        error_symbol = "[=>>](bold red)";
      };
      add_newline = false;
      git_branch = {
        disabled = true;
      };
      git_status = {
        disabled = true;
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    # historySubstringSearch.enable = true;

    shellAliases = {
      nixos-update = "sudo nixos-rebuild switch --flake '/home/mdario/NixOS#mdario'";
      home-manager-update = "home-manager switch --flake '/home/mdario/NixOS#mdario'";
      fan-on = "sudo ~/Github/isw/result/usr/bin/isw -w 16R3EMS1";
      ga = "git add .";
      gc = "git commit -m";
    };

    ohMyZsh = {
      enable = true;
      theme = "awesomepanda";
      plugins = [ 
        "sudo"
        # "zsh-history-substring-search" 
      ];
    };
  };
}
