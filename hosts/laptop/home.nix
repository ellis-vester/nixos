{ config, pkgs, ... }:

{
  home.username = "ellis";
  home.homeDirectory = "/home/ellis";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
    pkgs.neovim
    pkgs.git
    pkgs.gcc
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.file = {
    ".config/nvim".source = ../../dotfiles/config/nvim;
    ".config/wallpapers".source = ../../dotfiles/wallpapers;
  };

  gtk.enable = true;

  gtk.cursorTheme.package = pkgs.nordzy-cursor-theme;
  gtk.cursorTheme.name = "Nordzy-cursors";

  gtk.iconTheme.package = pkgs.nordzy-icon-theme;
  gtk.iconTheme.name = "Nordzy";

  gtk.theme.package = pkgs.nordic;
  gtk.theme.name = "Nordic";

  dconf = {
    enable = true;
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        user-themes.extensionUuid
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
    settings."org/gnome/shell/extensions/user-theme".name = "Nordic";
  };

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

    shellIntegration.enableZshIntegration = true;

    theme = "Nord";
    font.name = "JetBrainsMono Nerd Font";

    settings = {
      shell = "zsh";
      background_opacity = "0.85";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
