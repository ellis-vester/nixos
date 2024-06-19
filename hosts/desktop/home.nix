{ config, pkgs, catppuccin, inputs, ... }:

{
  home.username = "ellis";
  home.homeDirectory = "/home/ellis";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/gnome.nix
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

  gnome.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 100000;
      path = "/home/ellis/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };
  };

  programs.kitty = {
    enable = true;
    catppuccin.enable = true;
    catppuccin.flavor = "frappe";

    shellIntegration.enableZshIntegration = true;

    font.name = "JetBrainsMono Nerd Font";

    settings = {
      shell = "zsh";
      background_opacity = "0.75";
      hide_window_decorations = "yes";
      background_blur = "40";
    };
  };

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

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
