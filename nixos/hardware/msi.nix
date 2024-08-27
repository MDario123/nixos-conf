{ config, lib, pkgs, ... }:

{
  services.isw = {
    enable = true;

    # The default section created by this configuration is `NIX`
    # By changhing this value it is possible to load a different section
    # - A default one already defined in the config file
    # - Or a custom one defined in extraConfig
    section = "NIX";
    address_profile = "MSI_ADDRESS_DEFAULT";

    # 12:  Auto mode
    # 76:  Simple mode
    # 140: Advanced mode
    fan_mode = 140;

    cpu = {
      temp = {
        _0 = 25;
        _1 = 40;
        _2 = 50;
        _3 = 60;
        _4 = 70;
        _5 = 85;
      };

      speed = {
        _0 = 10;
        _1 = 25;
        _2 = 40;
        _3 = 50;
        _4 = 60;
        _5 = 75;
        _6 = 150;
      };
    };

    gpu = {
      temp = {
        _0 = 25;
        _1 = 40;
        _2 = 50;
        _3 = 60;
        _4 = 70;
        _5 = 85;
      };

      speed = {
        _0 = 10;
        _1 = 25;
        _2 = 40;
        _3 = 50;
        _4 = 60;
        _5 = 75;
        _6 = 150;
      };
    };

    extraConfig = ''
      # This gets appended at the end of isw.conf
    '';
  };
}
