{ pkgs, config, ... }:

{
  home.username = "mdario";
  home.homeDirectory = "/home/mdario";

  xdg.dataFile."sounds/MDario-theme/" = {
    source = ../Assets/sounds/My-theme;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "MDario123";
        email = "manuel.dario.oliver@gmail.com";
      };
      credential.helper = "oauth";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      rerere.enabled = true;
      pull.rebase = false;
    };
    ignores = [
      ".rustfmt.toml"
    ];
  };

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

  # You should not change this value
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = false;
}
