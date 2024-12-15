{ inputs, config, lib, pkgs, system, ... }:

let
  hydrated-sloth = pkgs.rust.packages.stable.rustPlatform.buildRustPackage {
    name = "hydrated-sloth";
    src = pkgs.fetchFromGitHub {
      owner = "MDario123";
      repo = "hydrated_sloth";
      rev = "7cc0620fb2875105c49fb8df9348ec3923e735d5";
      hash = "sha256-ZWR+dVzVBaMLrWPnDLWzattHmqhzmQ86olIt30EN9ws=";
    };

    cargoHash = "sha256-JSiMf1gTLchXiNdp7AxUvHfiHeLbiS8Jlzvg8f+Or5g=";

    nativeBuildInputs = with pkgs; [
      pkg-config
      gcc
      rustc
      cargo
    ];

    buildInputs = with pkgs; [
      glib
      pango
      gdk-pixbuf
      gtk3
    ];
  };
in
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
    libnotify
    mako
    playerctl
    zenity

    # Utility to keep track of sleep and hydration
    hydrated-sloth

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
