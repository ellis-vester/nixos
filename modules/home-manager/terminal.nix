{ config, pkgs, inputs, lib, ...}:

{
  options = {
    terminal.enable = lib.mkEnableOption "configures kitty and zsh";
  };

  config = lib.mkIf config.terminal.enable {
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

    home.file = {
      ".config/kitty-session".source = ../../dotfiles/config/kitty;
    };

    programs.kitty = {
      enable = true;

      shellIntegration.enableZshIntegration = true;

      font.name = "JetBrainsMono Nerd Font";

      settings = {
        shell = "zsh";
        background_opacity = "0.75";
        hide_window_decorations = "yes";
        startup_session = "../kitty-session/session";
      };

      keybindings = {
        "ctrl+c" = "copy_or_interrupt";
        "ctrl+v" = "paste_from_clipboard";

        "ctrl+shift+j" = "previous_window";
        "ctrl+shift+k" = "next_window";
      };
    };
  };
}
