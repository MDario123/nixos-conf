{ config, lib, pkgs, ... }:

{
  programs.git.enable = true;
  
  environment.systemPackages = with pkgs; [
    cargo
    gcc
    git-credential-oauth
  ];
}

