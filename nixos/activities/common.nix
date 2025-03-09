{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qmplay2-qt5
    yazi
  ];
}
