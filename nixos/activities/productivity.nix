{ pkgs, unstable-pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unstable-pkgs.obsidian
    taskwarrior3
    taskwarrior-tui
  ];
}
