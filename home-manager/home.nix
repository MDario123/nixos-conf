{ pkgs, ... }:

{
  home.username = "mdario";
  home.homeDirectory = "/home/mdario";

  xdg.dataFile."sounds/MDario-theme/" = {
    source = ../Assets/sounds/My-theme;
  };

  programs.git = {
    enable = true;
    userName = "MDario123";
    userEmail = "manuel.dario.oliver@gmail.com";
    extraConfig = {
      credential.helper = "oauth";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = false;
    };
  };

  # You should not change this value
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    (pkgs.writeShellScriptBin "cpd" ''
      cp ~/Downloads/$1 $2
    '')
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionPath = [ "$HOME/.local/bin" ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = false;
}
