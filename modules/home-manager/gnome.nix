{ pkgs, lib, config, ...}:

{
  options = {
    gnome.enable = lib.mkEnableOption "configures GDM and GNOME";
  };

  config = lib.mkIf config.gnome.enable {

    home.packages = with pkgs.gnomeExtensions; [
      user-themes
      forge
      blur-my-shell
    ];

    home.file = {
      ".config/forge/stylesheet/forge".source = ../../dotfiles/config/forge/stylesheet/forge;
    };

    dconf = {
      enable = true;
      settings."org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          user-themes.extensionUuid
          forge.extensionUuid
          blur-my-shell.extensionUuid
        ];
        favorite-apps = [
          "org.gnome.Nautilus.desktop"
          "kitty.desktop"
          "firefox.desktop"
          "signal-desktop.desktop"
          "spotify.desktop"
          "discord.desktop"
        ];
      };
    };
  };
}
