{ pkgs, ... }:
{
  # Bluetooth (GUI)
  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    nextcloud-client
  ];
}
