# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.05";
  home-manager.useGlobalPkgs = true;
  nixpkgs.config.allowUnfree = true;

  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default

      # Modules
      ../../modules/nixos/hyprland.nix
      ../../modules/nixos/gnome.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-2eb837b6-8198-4290-bc69-ed9c24e1eff6".device = "/dev/disk/by-uuid/2eb837b6-8198-4290-bc69-ed9c24e1eff6";
  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  gnome.enable = true;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
  
  users.users.ellis = {
    isNormalUser = true;
    description = "ellis";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrainsMono"];
      };
    };
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Steam/Gaming
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = [
    # Utilities
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
    pkgs.xwayland
    pkgs.wireplumber
    pkgs.dig

    # Backups
    pkgs.synology-drive-client
  ];

  system.autoUpgrade = {
    enable = true;
    flake = "${inputs.self.outPath}#desktop";
    flags = [
      "--commit-lock-file"
      "-L" # print build logs
    ];
    dates = "Mon *-*-* 04:15:00";
    randomizedDelaySec = "15min";
  };

  nix.optimise = {
    automatic = true;
    dates = [
      "09:00"
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "Mon *-*-* 12:00:00";
    options = "--delete-older-than 30d";
  };
}
