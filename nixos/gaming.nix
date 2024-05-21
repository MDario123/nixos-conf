{ config, lib, pkgs, ... }:

{
  hardware.xpadneo.enable = true;
  environment.systemPackages = with pkgs; [
    gamemode
    lutris
    mangohud
    ppsspp
    steam
    steam-run
    vulkan-tools
  ];

  programs.gamescope = {
    enable = true;
    args = [
      # "--expose-wayland"
    ];
    # env = {
    #   __NV_PRIME_RENDER_OFFLOAD = "1";
    #   __VK_LAYER_NV_optimus = "NVIDIA_only";
    #   __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # };
  };

  hardware.steam-hardware.enable = true;
  programs.steam = {
    enable = true;
    extest.enable = true;

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
