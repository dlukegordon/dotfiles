{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Need latest version for shaders and other features, but it also breaks caps/esc swapping.
    # Using this patched fork until issue is fixed.
    # https://github.com/ghostty-org/ghostty/discussions/7356
    ghostty.url = "github:weskoerber/ghostty/main";
    # ghostty.url = "github:ghostty-org/ghostty/tip";
    # ghostty.url = "github:ghostty-org/ghostty/7f9bb3c0e54f585e11259bc0c9064813d061929c";
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      plasma-manager,
      stylix,
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
    };
}
