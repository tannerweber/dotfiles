{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    {
      nixosConfigurations = {
        desktop-main-server =
          let
            hostname = "desktop-main-server";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [
              ./hosts/${hostname}/configuration.nix
              ./nixosModules
              ../nixosModulesShared
            ];
          };
      };
    };
}
