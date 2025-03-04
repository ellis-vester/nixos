{
  config,
  lib,
  ...
}: {
  options = {
    terminal.enable = lib.mkEnableOption "configures kitty and zsh";
  };

  config = lib.mkIf config.terminal.enable {
    xdg.enable = true;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      dotDir = ".config/zsh/";

      shellAliases = {
        ednv = "nvim /home/ellis/nixos/dotfiles/config/nvim/init.lua";
        ednx = "cd /home/ellis/nixos/ && nvim /home/ellis/nixos/flake.nix";
      };

      history = {
        size = 100000;
        path = "${config.home.sessionVariables.XDG_CACHE_HOME}/zsh/.zsh_history";
      };
    };

    programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = "catppuccin";
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
        hide_window_decorations = "no";
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
