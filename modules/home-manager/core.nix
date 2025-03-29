{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    core.enable = lib.mkEnableOption "install and configure core tools for all systems";
  };

  config = lib.mkIf config.core.enable {

    home.packages = [
      pkgs.gcc
      pkgs.obsidian
      pkgs.calibre
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.protonvpn-gui
      pkgs.btop
      pkgs.strawberry
    ];

    programs.librewolf = {
      enable = true;
      settings = {
        "identity.fxaccounts.enabled" = true;
      };
    };
  };
}
