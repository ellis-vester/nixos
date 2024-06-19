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
  ];

  home.packages = [
    pkgs.neovim
    pkgs.git
    pkgs.gcc
    pkgs.catppuccin-gtk
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.file = {
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink ../../dotfiles/config/nvim;
    ".config/wallpapers".source = ../../dotfiles/wallpapers;
  };

  gnome.enable = true;
  terminal.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
