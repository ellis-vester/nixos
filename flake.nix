{
  description = "Nixos config for personal systems.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, stylix, ... }@inputs: {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs; };
      modules = [
        ./hosts/laptop/configuration.nix
        inputs.home-manager.nixosModules.default
        stylix.nixosModules.stylix
      ];
    };
  };
}
