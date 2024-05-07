{ config, lib, pkgs, ... }:

{
  boot.kernelModules = [ "xpadneo" ];
  environment.systemPackages = with pkgs; [
    ppsspp
  ];
}

