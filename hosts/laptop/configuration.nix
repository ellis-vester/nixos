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

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  boot.loader.grub.enableCryptodisk = true;

  boot.initrd.luks.devices."luks-de84fb01-2fcc-462a-aace-9ae439573ad2".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

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
