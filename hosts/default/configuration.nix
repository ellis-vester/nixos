# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  boot.loader.grub.enableCryptodisk=true;

  boot.initrd.luks.devices."luks-de84fb01-2fcc-462a-aace-9ae439573ad2".keyFile = "/crypto_keyfile.bin";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE sddm Diplay Manager.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.displayManager.sddm.wayland.enable = true;
  # services.xserver.desktopManager.plasma6.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable bluetooth support
  hardware.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable flake support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
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

  stylix.enable = true;
  stylix.image = ../../dotfiles/wallpapers/502268.jpg;

  # Set default fonts. Installed in home.nix file
  fonts = {
    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
      };
    };
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.wget
    pkgs.hyprland
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
    pkgs.xwayland
    pkgs.rofi-wayland
    pkgs.waybar
    pkgs.hyprpaper
    pkgs.dunst
    pkgs.wireplumber
    pkgs.greetd.tuigreet
    pkgs.hyprshot

    # Programming Languages
    pkgs.go
    pkgs.rustup
    pkgs.dotnetCorePackages.sdk_8_0_2xx

    # Programming tools
    pkgs.gh

    # Packages for themes settings to work.
    # pkgs.libsForQt5.qtstyleplugin-kvantum
    # pkgs.kdePackages.knewstuff
    # pkgs.kdePackages.ksvg
    # pkgs.kdePackages.kdeclarative
  ];

  # https://discourse.nixos.org/t/howto-disable-most-gnome-default-applications-and-what-they-are/13505
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
