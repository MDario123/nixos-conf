{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qmplay2-qt6
    yazi
  ];
}
