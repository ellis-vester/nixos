{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    development.enable = lib.mkEnableOption "install and configure development tools";
  };

  config = lib.mkIf config.development.enable {

    home.packages = with pkgs; [

      # Go
      go
      delve
      gopls

      # Rust
      cargo
      rustfmt
      rustc
      rust-analyzer

      # Git
      git
      gh

      # Hashicorp
      terraform
      terraform-ls
      packer

      # AWS
      awscli2

      # Nix
      nixd
      alejandra

      # Lua
      lua
      lua-language-server
      stylua

      # Dotnet
      dotnetCorePackages.sdk_8_0_3xx
      csharp-ls
      csharpier

      # Other
      sqlite
      sqlitebrowser
    ];
  };
}
