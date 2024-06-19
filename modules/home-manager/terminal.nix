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
      };
    };
  };
}
