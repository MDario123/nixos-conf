{  pkgs,
  unstable-pkgs
, ...
}:

{
  programs.gamemode = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    flitter
    lutris
    mangohud
    ppsspp
    ryubing
    steam
    steam-run
    vulkan-tools
    teamspeak3

    # Game
    osu-lazer
    prismlauncher

    unstable-pkgs.deadlock-mod-manager
    unstable-pkgs.rustdesk
  ];

  programs.haguichi.enable = true;
  services.tailscale = {
    enable = true;
  };

  programs.steam = {
    enable = true;
    # extest.enable = true;
    gamescopeSession.enable = true;

    dedicatedServer.openFirewall = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
