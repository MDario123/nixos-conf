{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "FantasqueSansM Nerd Font Mono";
      size = 16;
      package = with pkgs; (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; });
    };
    settings = {
      tab_bar_min_tabs = 1;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
    };
    theme = "Catppuccin-Mocha";
  };

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
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    # historySubstringSearch.enable = true;

    shellAliases = {
      nixos-update = "sudo nixos-rebuild switch --flake '/home/mdario/NixOS#mdario'";
      home-manager-update = "home-manager switch --flake '/home/mdario/NixOS#mdario'";
      fan-on = "sudo ~/Github/isw/result/usr/bin/isw -w 16R3EMS1";
      code = "nix develop";
      ga = "git add .";
      gc = "git commit -m";
      gac = "git add . && git commit -m";
    };

    oh-my-zsh = {
      enable = true;
      theme = "awesomepanda";
      plugins = [
        "sudo"
        # "zsh-history-substring-search" 
      ];
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
