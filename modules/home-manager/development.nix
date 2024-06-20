{ pkgs, lib, config, ...}:

{
  options = {
    development.enable = lib.mkEnableOption "install and configure development tools";
  };

  config = lib.mkIf config.development.enable {
    home.packages = with pkgs; [
      go
      delve
      rustup
      dotnetCorePackages.sdk_8_0_2xx
      git
      gh
    ];
  };
}
