{ pkgs, ... }:
{
  imports = [
    ./nvidia.nix
    ./auto-generated.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Disable PSR, since it currently causes some important bugs
  boot.kernelParams = [ "amdgpu.dcdebugmask=0x210" ];

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    wireplumber = {
      enable = true;
      extraConfig = {
        bluetoothEnhancements = {
          # "bluez5.enable-sbc-xq" = true;
          # "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = false;
          # "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
        };

        "disable-extra-sinks" = {
          "monitor.alsa.rules" = [
            {
              matches = [
                {
                  "node.name" = "~alsa_output.pci-0000_01_00.1.*";
                }
              ];
              actions = {
                update-props = {
                  "node.disabled" = true;
                };
              };
            }
            {
              matches = [
                {
                  "node.name" = "~alsa_output.pci-0000_05_00.1.*";
                }
              ];
              actions = {
                update-props = {
                  "node.disabled" = true;
                };
              };
            }
          ];
        };

      };
    };
    extraConfig = {
      pipewire-pulse = {
        "pulse.cmd" = [
          {
            cmd = "load-module";
            args = "module-switch-on-connect";
          }
        ];
      };
    };
  };

  # Screen backlight
  programs.light.enable = true;


  specialisation.nvidialess = {
    inheritParentConfig = true;

    configuration = {
      boot.extraModprobeConfig = ''
        blacklist nouveau
        options nouveau modeset=0
      '';

      services.udev.extraRules = ''
        # Remove NVIDIA USB xHCI Host Controller devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA USB Type-C UCSI devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA Audio devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA VGA/3D controller devices
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
      '';
      boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
    };
  };
}
