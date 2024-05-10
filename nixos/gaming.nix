{ config, lib, pkgs, ... }:

{
  hardware.xpadneo.enable = true;
  environment.systemPackages = with pkgs; [
    ppsspp
    lutris
    steam
    steam-run
  ];

  # Steam 
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

}

