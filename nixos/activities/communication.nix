{ config, lib, pkgs, ... }:

{
  # hardware.xpadneo.enable = true;
  environment.systemPackages = with pkgs; [
    discord
    telegram-desktop
    slack
  ];
}
