{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ./programs/cliprograms.nix
    ./services/caddy.nix
    ./services/glance.nix
    ./services/homepage-dashboard.nix
    ./services/jellyfin.nix
    ./services/mealie.nix
    ./services/miniflux.nix
  ];
}
