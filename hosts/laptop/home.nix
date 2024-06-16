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

    settings = {
      shell = "zsh";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
