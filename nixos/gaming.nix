{ config, lib, pkgs, ... }:

{
  hardware.xpadneo.enable = true;
  hardware.xone.enable = true;
  environment.systemPackages = with pkgs; [
    ppsspp
  ];
}

