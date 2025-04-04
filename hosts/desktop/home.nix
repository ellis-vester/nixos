{
  pkgs,
  ...
}: {
  home.username = "ellis";
  home.homeDirectory = "/home/ellis";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ../../modules/home-manager/core.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/gnome.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/themes.nix
    ../../modules/home-manager/neovim.nix
    ../../modules/home-manager/development.nix
    ../../modules/home-manager/social.nix
  ];

  home.packages = [
    pkgs.darktable
    pkgs.buckets
  ];

  home.file = {
    ".config/wallpapers".source = ../../dotfiles/wallpapers;
  };

  core.enable = true;
  gnome.enable = true;
  hyprland.enable = false;
  themes.enable = true;
  terminal.enable = true;
  neovim.enable = true;
  development.enable = true;
  social.enable = true;

  programs.home-manager.enable = true;

  # Virtual Machines
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
