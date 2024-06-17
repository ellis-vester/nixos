{ config, pkgs, lib, ...}:

{
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyperland module";
  };

  config = lib.mkIf config.hyprland.enable {
    home.file = {
      ".config/hypr".source = ../../dotfiles/config/hypr;
      ".config/waybar".source = ../../dotfiles/config/waybar;
      ".config/rofi".source = ../../dotfiles/config/rofi;
      ".config/wallpapers".source = ../../dotfiles/wallpapers;
    };
  };
}
