{ pkgs, lib, config, inputs, ...}:

{
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

    gtk.enable = true;
    gtk.catppuccin.enable = true;
    gtk.catppuccin.flavor = "frappe";
    gtk.catppuccin.accent = "rosewater";

    gtk.catppuccin.icon.enable = false;

    gtk.iconTheme.package = pkgs.nordzy-icon-theme;
    gtk.iconTheme.name = "Nordzy";

    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "frappe";
        windowManagerPatch = true;
      };
  };
}
