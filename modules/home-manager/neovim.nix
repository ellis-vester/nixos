{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    neovim.enable = lib.mkEnableOption "install and configure Neovim";
  };

  config = lib.mkIf config.neovim.enable {
    home.packages = with pkgs; [
      neovim
      unzip # required for stylua
      ripgrep # required for treesitter
    ];

    home.file = {
      ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/config/nvim";
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
