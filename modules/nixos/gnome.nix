{ pkgs, lib, config, ... }:

{
  options = {
    gnome.enable = lib.mkEnableOption "enables GDM and GNOME";
  };

  config = lib.mkIf config.gnome.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
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
  };
}
