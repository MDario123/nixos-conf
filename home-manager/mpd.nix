{ pkgs, config, ... }:

{
  services.mpdris2 = {
    enable = true;
    notifications = true;

    mpd = {
      host = "127.0.0.1";
      port = 6600;
      musicDirectory = "${config.home.homeDirectory}/Music";
    };
  };

}
