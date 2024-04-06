{ config, lib, pkgs, ... }:

{
  programs.git.enable = true;
  
  environment.systemPackages = with pkgs; [
    gcc
    git-credential-oauth
  ];
}

