{ config, lib, pkgs, ... }:

{
  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    cachix
    cargo
    gcc
    gh
    # haskell compiler (here for the interactive version "ghci")
    ghc
    git-credential-oauth
    vscode

    postman
  ];
}
