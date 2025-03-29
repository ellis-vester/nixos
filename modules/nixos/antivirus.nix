{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    antivirus.enable = lib.mkEnableOption "install and configure anti-virus";
  };

  config = lib.mkIf config.antivirus.enable {

    environment.systemPackages = [
      pkgs.clamav
    ];

    services.clamav.daemon.enable = true;
    services.clamav.updater.enable = true;

    services.clamav.daemon.settings = {
      OnAccessPrevention = true;
      OnAccessIncludePath = "/home/ellis/Downloads";
      OnAccessExcludeUname = "clamav";
    };
  };
}
