{ config, pkgs, catppuccin, inputs, ... }:

{
  home.username = "ellis";
  home.homeDirectory = "/home/ellis";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/gnome.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/themes.nix
    ../../modules/home-manager/neovim.nix
    ../../modules/home-manager/development.nix
  ];

  home.packages = [
    pkgs.gcc
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.file = {
    ".config/wallpapers".source = ../../dotfiles/wallpapers;
  };

  gnome.enable = true;
  hyprland.enable = false;
  themes.enable = true;
  terminal.enable = true;
  neovim.enable = true;
  development.enable = true;

  programs.home-manager.enable = true;
}
