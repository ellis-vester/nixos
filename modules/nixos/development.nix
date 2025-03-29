{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    development.enable = lib.mkEnableOption "install and configure anti-virus";
  };

  config = lib.mkIf config.development.enable {

    environment.systemPackages = [
      # Utilities
      pkgs.openssl
      pkgs.pkg-config
      pkgs.bws

      # Containers
      pkgs.podman-compose
    ];

    # Enable common container config files in /etc/containers
    virtualisation.containers.enable = true;
    virtualisation = {
      podman = {
        enable = true;

        # Create a `docker` alias for podman, to use it as a drop-in replacement
        dockerCompat = true;

        # Required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings.dns_enabled = true;
      };
    };
  };
}
