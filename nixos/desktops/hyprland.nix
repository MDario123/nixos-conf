{ inputs, config, lib, pkgs, system, ... }:

{

  xdg.mime.defaultApplications."inode/directory" = "nemo.desktop";

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true; # enable the graphical frontend
  security.pam.services.gdm.enableGnomeKeyring = true; # load gnome-keyring at startup
  environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";

  programs.hyprland = {
    enable = true;
  };

  # Screen backlight
  programs.light.enable = true;
  # Bluetooth (GUI)
  services.blueman.enable = true;

  # mpd (music player)
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
    mpc-cli
    slurp
    waybar
    ymuse
    youtube-dl
    gnome.zenity

    # Simple and flexbile QtQuick based desktop shell toolkit.
    # https://git.outfoxxed.me/outfoxxed/quickshell
    inputs.quickshell.packages.${system}.default

    # Application picker
    # https://codeberg.org/dnkl/fuzzel
    fuzzel
    # https://github.com/marty-oehme/bemoji
    bemoji
  ];
}
