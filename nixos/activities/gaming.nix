{ config, lib, pkgs, ... }:

{
  # hardware.xpadneo.enable = true;
  environment.systemPackages = with pkgs; [
    lutris
    mangohud
    ppsspp
    steam
    steam-run
    vulkan-tools
    temurin-jre-bin

    # Game
    osu-lazer
    prismlauncher
  ];

  # hardware.steam-hardware.enable = true;
  programs.steam = {
    enable = true;
    # extest.enable = true;

    dedicatedServer.openFirewall = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
