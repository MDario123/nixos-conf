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

  xdg.mime.defaultApplications."inode/directory" = "nemo.desktop";

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true; # enable the graphical frontend
  security.pam.services.gdm.enableGnomeKeyring = true; # load gnome-keyring at startup
  security.pam.services.gdm-password.enableGnomeKeyring = true;
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
    # network.listenAddress = "any"; # allow non-localhost connections
  };

  # NFS server
  fileSystems."/export/Music" = {
    device = "/home/mdario/Music";
    options = [ "bind" ];
  };
  services.static-web-server = {
    enable = true;
    listen = "[::]:80";
    root = "/export";
    configuration = {
      general = {
        directory-listing = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    alsa-utils
    bc
    eww
    hyprlock
    hyprpaper
    libsecret
    libnotify
    lxappearance
    mako
    mpc-cli
    ymuse
    zenity

    # Utility to keep track of sleep and hydration
    hydrated-sloth

    # PulseAudio GUI
    pavucontrol

    # Helper for screenshots within Hyprland, based on grimshot
    # https://github.com/hyprwm/contrib/tree/main/grimblast
    grimblast

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
