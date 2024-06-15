{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ellis";
  home.homeDirectory = "/home/ellis";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.tmux
    pkgs.neovim
    pkgs.git
    pkgs.gcc
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    ".bashrc".source = ../../dotfiles/bashrc;
    ".config/nvim".source = ../../dotfiles/config/nvim;
    ".tmux.config".source = ../../dotfiles/tmux.config;
    ".config/hypr".source = ../../dotfiles/config/hypr;
    ".config/waybar".source = ../../dotfiles/config/waybar;
    ".config/rofi".source = ../../dotfiles/config/rofi;
    ".config/wallpapers".source = ../../dotfiles/wallpapers;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
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
 
  xdg.mimeApps.defaultApplications = {
    "image/jpeg" = [ "gwenview" ];
    "image/png" = [ "gwenview" ];
  };

    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    stylix.autoEnable = true;
    stylix.opacity.applications = 0.85;
    stylix.opacity.terminal = 0.85;
    stylix.targets.kde.enable = false;

   # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ellis/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
