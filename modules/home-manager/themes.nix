{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    themes.enable = lib.mkEnableOption "configures themes for applications and DE";
  };

  config = lib.mkIf config.themes.enable {
    home.packages = with pkgs; [
      neofetch
      catppuccin-gtk
      nerd-fonts.jetbrains-mono
    ];

    home.file = {
      ".config/wallpapers".source = ../../dotfiles/wallpapers;
    };

    catppuccin.enable = true;
    catppuccin.flavor = "frappe";
    catppuccin.accent = "rosewater";

    catppuccin.gtk.enable = true;
    catppuccin.gtk.icon.enable = false;

    catppuccin.kitty.enable = true;

    gtk.enable = true;

    gtk.iconTheme.package = pkgs.nordzy-icon-theme;
    gtk.iconTheme.name = "Nordzy";

    programs.spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "frappe";
      windowManagerPatch = true;
    };
  };
}
