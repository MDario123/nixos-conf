{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    telegram-desktop
    slack
    zapzap
  ];
}
