{ config, lib, pkgs, ... }:

{
  programs.git.enable = true;
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    cargo
    gcc
    # haskell compiler (here for the interactive version "ghci")
    ghc
    git-credential-oauth

    ollama-cuda
  ];
}
