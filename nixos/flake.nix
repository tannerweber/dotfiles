{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    {
      nixosConfigurations = {
        lt1504 =
          let
            hostname = "lt1504";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [
              ./hosts/${hostname}/configuration.nix
              ./nixosModules
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  backupFileExtension = "backup";
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = { inherit inputs; };
                  sharedModules = [ ./homeManagerModules ];
                  users = {
                    tannerw = import ./hosts/${hostname}/home.nix;
                  };
                };
              }
            ];
          };

        desktop-main =
          let
            hostname = "desktop-main";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [
              ./hosts/${hostname}/configuration.nix
              ./nixosModules
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  backupFileExtension = "backup";
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = { inherit inputs; };
                  sharedModules = [ ./homeManagerModules ];
                  users = {
                    tannerw = import ./hosts/${hostname}/home.nix;
                  };
                };
              }
            ];
          };
      };
    };
}
