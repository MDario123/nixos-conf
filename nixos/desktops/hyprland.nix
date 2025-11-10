{ inputs, config, lib, pkgs, system, ... }:

{
  imports = [
    ./common.nix
  ];

  services.displayManager.defaultSession = "hyprland";

  xdg.mime.defaultApplications."inode/directory" = "nemo.desktop";

  programs.hyprland = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    # alsa-utils
    decibels
    eww
    hdrop
    hypridle
    hyprlock
    hyprpaper
    hyprsunset
    libnotify
    mako
    playerctl
    zenity

    # Drag and drop utility https://github.com/mwh/dragon
    dragon-drop

    # PulseAudio GUI
    pavucontrol

    # Helper for screenshots within Hyprland, based on grimshot
    # https://github.com/hyprwm/contrib/tree/main/grimblast
    grimblast

    # Application picker
    # https://codeberg.org/dnkl/fuzzel
    fuzzel
    # https://github.com/marty-oehme/bemoji
    bemoji
  ];
}
