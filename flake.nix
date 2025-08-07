{
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Walker (Launcher)
    walker.url = "github:abenz1267/walker";
  };

  outputs = { self, nixpkgs, darwin, ... }@inputs:
    {
      nixosConfigurations = {
        akadem = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/akadem ];
        };
      };

      darwinConfigurations = {
        mezhdura = darwin.lib.darwinSystem {
          specialArgs = { inherit self; };
          modules = [ ./hosts/mezhdura ];
        };
      };
    };
}
