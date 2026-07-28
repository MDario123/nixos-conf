{ pkgs, unstable-pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  environment.systemPackages = with pkgs; [
    cachix
    cargo
    unstable-pkgs.claude-code
    gcc
    gh
    # haskell compiler (here for the interactive version "ghci")
    ghc
    git-credential-oauth
    hyperfine

    ldtk

    godot
    aseprite
  ];
}
