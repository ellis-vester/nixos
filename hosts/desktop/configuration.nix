{
  config,
  pkgs,
  inputs,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.stateVersion = "24.05";
  home-manager.useGlobalPkgs = true;
  nixpkgs.config.allowUnfree = true;

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default

    # Modules
    ../../modules/nixos/antivirus.nix
    ../../modules/nixos/core.nix
    ../../modules/nixos/development.nix
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/hyprland.nix
  ];

  antivirus.enable = true;
  core.enable = true;
  development.enable = true;
  gnome.enable = true;

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

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  # Steam/Gaming
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Virtual Machines
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["ellis"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # Keyboard Setup
  hardware.keyboard.zsa.enable = true;
  environment.systemPackages = with pkgs; [ keymapp ];

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
