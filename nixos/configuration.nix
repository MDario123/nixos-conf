# Edit this configuration file to define what should be installed on # your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Support NTFS
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "MDario"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  services.libinput.enable = true;
  # X11 windowing system.
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.options = "caps:backspace";
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Enable sound.
  hardware.pulseaudio.enable = true;

  programs.zsh.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mdario = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" ];
    packages = with pkgs; [
      aria2
      (nemo-with-extensions.override {
        useDefaultExtensions = false;
        extensions = [ nemo-fileroller ];
      })
      discord
      filezilla
      # web browser
      firefox
      # for reading ebooks
      foliate
      # terminal emulator
      kitty
      # for painting
      krita
      libreoffice
      papirus-icon-theme
      telegram-desktop
      wine
    ];
  };
  users.defaultUserShell = pkgs.zsh;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bottom
    eza
    fd
    fzf
    hakuneko
    home-manager
    htop
    lshw
    jq
    neovim
    obsidian
    openvpn
    ouch
    ripgrep
    socat
    starship
    tldr
    tree
    unrar
    unzip
    vim
    wget
    wl-clipboard
    w3m
    zoxide
  ];

  environment.variables = {
    SHELL = "$(which zsh)";
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    font-awesome
  ];

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Do NOT change this value 
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

}
