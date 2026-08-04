{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ./locality.nix
    ./hardware/nvidia.nix
    ./programs/cliprograms.nix
    ./programs/vim.nix
    ./services/glance.nix
    ./services/homepage-dashboard.nix
    ./services/jellyfin.nix
    ./services/miniflux.nix
    ./services/openssh.nix
  ];
}
