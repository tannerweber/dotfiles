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
    ./programs/vim.nix
    ./services/openssh.nix
  ];
}
