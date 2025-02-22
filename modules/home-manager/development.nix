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
      dotnetCorePackages.sdk_8_0_3xx
      git
      gh
      terraform
      packer
      awscli2
      vscode
      godot_4-mono
    ];
  };
}
