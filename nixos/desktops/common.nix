{ pkgs, unstable-pkgs, ... }:
{
  # Bluetooth (GUI)
  services.blueman.enable = true;

  environment.systemPackages = [
    pkgs.nextcloud-client
    unstable-pkgs.quickshell
  ];
}
