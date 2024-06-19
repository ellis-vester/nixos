{
  description = "Nixos config for personal systems.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, catppuccin, home-manager, ... }@inputs: {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/laptop/configuration.nix
        inputs.home-manager.nixosModules.default
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager {
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.ellis = {
            imports = [
              ./hosts/laptop/home.nix
              catppuccin.homeManagerModules.catppuccin
              inputs.spicetify-nix.homeManagerModules.default
            ];
          };
        }
      ];
    };
  };
}
