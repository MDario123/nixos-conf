{ config, pkgs, ... }:

{
  home.username = "mdario";
  home.homeDirectory = "/home/mdario";

  imports = [
    # ./nvim/nvim.nix
    ./terminal.nix
  ];

  home.pointerCursor = {
    gtk.enable = true;
    name = "BreezeX-RosePine-Linux";
    package = pkgs.rose-pine-cursor;
    size = 32;
  };
  
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Mauve-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "mauve";
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "MDario123";
    userEmail = "manuel.dario.oliver@gmail.com";
    extraConfig = {
      credential.helper = "oauth";
    };
  };

  services.mako = {
    enable = true;
    maxVisible = 5;
    output = "eDP-1";
    sort = "-time";
    layer = "overlay";
    anchor = "top-right";
    font = "FantasqueSansM Nerd Font Mono";
    backgroundColor = "#1E1E1E";
    textColor = "#D0F0F0";
    actions = true;
    width = 300;
    height = 200;
    margin = "10";
    padding = "5";
    borderSize = 2;
    borderColor = "#F38BA8";
    borderRadius = 6;
    progressColor = "over #F38BA870";
    defaultTimeout = 5000;
    format = "<b>%s</b>\\n%b";
    groupBy = "app-name,summary";
    extraConfig = ''
      [grouped]
      format=<b>%s</b>\n%b
    '';
  };

  # You should not change this value
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    GTK_THEME= "Catppuccin-Mocha-Compact-Mauve-Dark";
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = false;
}
