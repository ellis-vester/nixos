{ config, pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.05";
  
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  boot.loader.grub.enableCryptodisk=true;

  boot.initrd.luks.devices."luks-de84fb01-2fcc-462a-aace-9ae439573ad2".keyFile = "/crypto_keyfile.bin";
  
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
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
    packages = with pkgs; [
      discord
      kitty
      neofetch
      spotify
    ];
  };

  home-manager = {
    extraSpecialArgs = { 
      inherit inputs;
    };
    users = {
      "ellis" = import ./home.nix;
    };
  };

  fonts = {
    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
      };
    };
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    # GNOME
    pkgs.gnome.gnome-tweaks

    # Utilities
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
    pkgs.xwayland
    pkgs.wireplumber

    # Programming Languages
    pkgs.go
    pkgs.delve
    pkgs.rustup
    pkgs.dotnetCorePackages.sdk_8_0_2xx

    # Programming tools
    pkgs.gh

    # Communication
    pkgs.signal-desktop

    # Backups
    pkgs.synology-drive-client
  ];

  environment.gnome.excludePackages = with pkgs.gnome; [
    baobab
    cheese
    eog
    epiphany
    simple-scan
    totem
    evince
    geary
    seahorse
    gnome-calendar
    gnome-contacts
  ];
}
