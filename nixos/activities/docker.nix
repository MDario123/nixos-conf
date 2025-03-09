{ ... }:

{
  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
  };
}
