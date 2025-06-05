{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    plasma-manager,
    stylix,
    ...
  }: {
    nixosConfigurations = {
      # Desktop
      valhalla = let
        system = "x86_64-linux";
        pkgsUnstable = import nixpkgs-unstable {inherit system;};
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit pkgsUnstable;};

          modules = [
            ./os/valhalla.nix
            stylix.nixosModules.stylix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.luke = import ./home/valhalla.nix;
                sharedModules = [
                  plasma-manager.homeManagerModules.plasma-manager
                ];
                extraSpecialArgs = {inherit pkgsUnstable;};
              };
            }
          ];
        };

      # Laptop
      asgard = let
        system = "x86_64-linux";
        pkgsUnstable = import nixpkgs-unstable {inherit system;};
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit pkgsUnstable;};

          modules = [
            ./os/asgard.nix
            stylix.nixosModules.stylix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.luke = import ./home/asgard.nix;
                sharedModules = [
                  plasma-manager.homeManagerModules.plasma-manager
                ];
                extraSpecialArgs = {inherit pkgsUnstable;};
              };
            }
          ];
        };

      # Local server
      nidavellir = let
        system = "x86_64-linux";
        pkgsUnstable = import nixpkgs-unstable {inherit system;};
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit pkgsUnstable;};

          modules = [
            ./os/nidavellir.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.luke = import ./home/nidavellir.nix;
                extraSpecialArgs = {inherit pkgsUnstable;};
              };
            }
          ];
        };

    };
  };
}
