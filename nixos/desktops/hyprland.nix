{ pkgs
, unstable-pkgs
, ...
}:

{
  imports = [
    ./common.nix
  ];

  services.displayManager.defaultSession = "hyprland";

  xdg.mime.defaultApplications."inode/directory" = "nemo.desktop";

  programs.hyprland = {
    enable = true;
    package = unstable-pkgs.hyprland;
  };

  environment.systemPackages = with pkgs; [
    # alsa-utils
    decibels
    eww
    hdrop
    unstable-pkgs.hypridle
    unstable-pkgs.hyprlock
    unstable-pkgs.hyprpaper
    unstable-pkgs.hyprshutdown
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
