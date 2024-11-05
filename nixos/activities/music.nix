{ pkgs, config, ... }:
{
  # mpd (music player)
  systemd.services.mpd.environment = {
    # User-id must match mpd user. MPD will look inside this directory for the PipeWire socket.
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users."mdario".uid}";
  };
  services.mpd = {
    enable = true;
    user = "mdario";
    musicDirectory = "${config.users.users."mdario".home}/Music";
    extraConfig = ''
      audio_output {
        type  "pipewire"
        name  "PipeWire Sound Server"
      }
    '';
    startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
    # network.listenAddress = "any"; # allow non-localhost connections
  };

  environment.systemPackages = with pkgs; [
    mpc-cli
    ymuse
  ];

  fileSystems."/export/Music" = {
    device = "/home/mdario/Music";
    options = [ "bind" ];
  };
}
