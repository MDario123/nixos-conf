{ config, lib, pkgs, ... }:

{
  hardware.xpadneo.enable = true;
  environment.systemPackages = with pkgs; [
    ppsspp
    lutris
    steam-run
  ];

  services.flatpak = {
    enable = true;
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      "flathub-beta" = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo";
    };
    packages = [
      "flathub:app/com.valvesoftware.Steam//stable"
    ];
    overrides = {
      "global" = {
        filesystems = [
          "/home/games/SteamLibrary/"
        ];
      };
    };
  };
}

