{ pkgs, lib, config, ...}:

{
  options = {
    neovim.enable = lib.mkEnableOption "install and configure Neovim";
  };

  config = lib.mkIf config.neovim.enable {
    home.packages = with pkgs; [
      neovim
    ];

    home.file = {
      ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink ../../dotfiles/config/nvim;
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
