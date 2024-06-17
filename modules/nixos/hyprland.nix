# hyprland.nix
{ pkgs, lib, config, ... }: 

{
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland module";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    environment.systemPackages = with pkgs; [
      hyprpaper
      hyprshot
      rofi-wayland
      waybar
      dunst
    ];
  };
}

