{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    opencode = {
      url = "github:anomalyco/opencode";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      plasma-manager,
      nix-darwin,
      ...
    }:
    {
      nixosConfigurations = {
        # Desktop
        valhalla =
          let
            system = "x86_64-linux";
            pkgsUnstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit pkgsUnstable inputs; };

            modules = [
              ./os/valhalla.nix

              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.luke = import ./home/valhalla.nix;
                  sharedModules = [
                    plasma-manager.homeModules.plasma-manager
                  ];
                  extraSpecialArgs = { inherit pkgsUnstable inputs; };
                };
              }
            ];
          };

        # Laptop
        asgard =
          let
            system = "x86_64-linux";
            pkgsUnstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit pkgsUnstable inputs; };

            modules = [
              ./os/asgard.nix

              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.luke = import ./home/asgard.nix;
                  sharedModules = [
                    plasma-manager.homeModules.plasma-manager
                  ];
                  extraSpecialArgs = { inherit pkgsUnstable inputs; };
                };
              }
            ];
          };

        # Local server
        nidavellir =
          let
            system = "x86_64-linux";
            pkgsUnstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit pkgsUnstable; };

            modules = [
              ./os/nidavellir.nix

              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.luke = import ./home/nidavellir.nix;
                  extraSpecialArgs = { inherit pkgsUnstable; };
                };
              }
            ];
          };

      };

      # Macbook
      darwinConfigurations."Gordon-MacBook-Pro-C7KM27FNVJ-M" =
        let
          system = "aarch64-darwin";
          pkgsUnstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        in
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = { inherit pkgsUnstable; };

          modules = [
            ./os/darwin.nix

            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.luke = import ./home/darwin.nix;
                extraSpecialArgs = { inherit pkgsUnstable; };
              };
            }
          ];
        };
    };
}
