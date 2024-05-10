{ config, lib, pkgs, ... }:

{
  hardware.xpadneo.enable = true;
  environment.systemPackages = with pkgs; [
    ppsspp
  ];
}

