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
      git
      gh
      terraform
      packer
      awscli2
      vscode-fhs
      godot_4-mono
      lua
      lua-language-server
      stylua

      # Dotnet
      dotnetCorePackages.sdk_8_0_3xx
      csharp-ls
    ];
  };
}
