{ config, lib, pkgs, ... }:

{
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true; # enable the graphical frontend
  security.pam.services.gdm.enableGnomeKeyring = true; # load gnome-keyring at startup
  environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";

  programs.hyprland = {
    enable = true;
  };

  programs.light.enable = true;

  hardware.pulseaudio.extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
  services.mpd = {
    enable = true;
    user = "mdario";
    musicDirectory = "${config.users.users."mdario".home}/Music";
    extraConfig = ''
      audio_output {
        type "pulse"
        name "PulseAudio" 
        server "127.0.0.1" 
      }
    '';
    startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
  };

  environment.systemPackages = with pkgs; [
    bc
    eww
    grim
    hyprlock
    hyprpaper
    libsecret
    libnotify
    mako
    mpc
    slurp
    waybar
    ymuse
    yofi
    youtube-dl
    gnome.zenity
  ];
}
