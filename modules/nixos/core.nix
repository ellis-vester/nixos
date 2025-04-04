{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    core.enable = lib.mkEnableOption "install and configure core tools for all systems";
  };

  config = lib.mkIf config.core.enable {

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
      # libvirtd required for virtualization
      extraGroups = ["networkmanager" "wheel" "libvirtd"];
    };

    environment.variables = rec {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      XDG_BIN_HOME = "$HOME/.local/bin";
      PATH = [
        "${XDG_BIN_HOME}"
      ];
    };

    fonts = {
      enableDefaultPackages = true;
      fontconfig = {
        defaultFonts = {
          monospace = ["JetBrainsMono"];
        };
      };
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];
    };
  };
}
