{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, plasma-manager, ... }: {
    nixosConfigurations = {

      # Desktop
      valhalla = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./nixos/valhalla.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.luke = import ./home/valhalla.nix;
            home-manager.sharedModules =
              [ plasma-manager.homeManagerModules.plasma-manager ];
          }
        ];
      };

      # Laptop
      niflheim = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./nixos/niflheim.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.luke = import ./home/niflheim.nix;
            home-manager.sharedModules =
              [ plasma-manager.homeManagerModules.plasma-manager ];
          }
        ];
      };

    };

  };
}
