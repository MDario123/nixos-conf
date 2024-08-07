{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "FantasqueSansM Nerd Font Mono";
      size = 13;
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
    extraConfig = ''
      map f1 launch --cwd=current
      map f2 close_window
      enabled_layouts tall,fat
    '';
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
        disabled = false;
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
      nixos-update-boot = "sudo nixos-rebuild boot --flake '/home/mdario/NixOS#mdario'";
      nixos-fully-collect-garbage = "sudo nix-collect-garbage -d && nixos-update-boot";
      home-manager-update = "home-manager switch --flake '/home/mdario/NixOS#mdario'";
      fan-on = "sudo ~/Github/isw/result/usr/bin/isw -w 16R3EMS1";
      code = "nix develop";
      gac = "git add . && git commit -m";
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

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
