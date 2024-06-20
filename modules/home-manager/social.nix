{ config, lib, pkgs, ...}:

{
  options = {
    social.enable = lib.mkEnableOption "installs and configures social/comms apps";
  };

  config = lib.mkIf config.social.enable {
    home.packages = with pkgs; [
      discord
      signal-desktop
    ];
  };
}
