{ config, lib, pkgs, ... }:

{
  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    cargo
    gcc
    # haskell compiler (here for the interactive version "ghci")
    ghc
    git-credential-oauth

    ollama-cuda
  ];
}
