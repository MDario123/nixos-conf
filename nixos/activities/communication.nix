{ pkgs
, ...
}:

{
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {
      cudaSupport = true;
    };
  };

  environment.systemPackages = with pkgs; [
    discord
    telegram-desktop
    slack
    zapzap
  ];
}
