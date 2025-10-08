{ config, lib, pkgs, ... }:

{
  hardware.xpadneo.enable = true;
  environment.systemPackages = with pkgs; [
    lutris
    mangohud
    ppsspp
    ryubing
    steam
    steam-run
    vulkan-tools
    teamspeak3

    # Game
    osu-lazer
    prismlauncher
  ];

  programs.haguichi.enable = true;

  programs.steam = {
    enable = true;
    # extest.enable = true;
    gamescopeSession.enable = true;

    dedicatedServer.openFirewall = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
