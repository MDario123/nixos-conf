{ config, lib, pkgs, ... }:

{
  hardware.xpadneo.enable = true;
  environment.systemPackages = with pkgs; [
    lutris
    mangohud
    ppsspp
    steam
    steam-run
    vulkan-tools
  ];

  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };
  users.users.mdario.extraGroups = [ "gamemode" ];

  hardware.steam-hardware.enable = true;
  programs.steam = {
    enable = true;
    # extest.enable = true;

    dedicatedServer.openFirewall = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # services.flatpak = {
  #   enable = true;
  #   remotes = {
  #     "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
  #     "flathub-beta" = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo";
  #   };
  #   packages = [
  #     "flathub:app/com.valvesoftware.Steam//stable"
  #   ];
  #   overrides = {
  #     "global" = {
  #       filesystems = [
  #         "/home/games/SteamLibrary/"
  #       ];
  #     };
  #   };
  # };
}
