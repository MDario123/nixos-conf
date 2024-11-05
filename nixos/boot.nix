{ pkgs, ... }:
{
  # Don't show text during boot
  boot.kernelParams = [ "quiet" "splash" ];
  boot.consoleLogLevel = 3;
  boot.loader = {
    efi = {
      canTouchEfiVariables = false;
    };
    grub = {
      enable = true;

      copyKernels = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
      fsIdentifier = "label";

      theme = "${pkgs.catppuccin-grub.override { flavor = "mocha"; }}/";

      extraEntries = ''
        menuentry "Reboot" {
          reboot
        }
        menuentry "Poweroff" {
          halt
        }
      '';
    };
  };
  # Support NTFS
  boot.supportedFilesystems = [ "ntfs" ];
}
