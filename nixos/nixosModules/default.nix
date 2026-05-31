{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ./programs/vim.nix
    ./services/kanata.nix
    ./services/rust-embedded-microbit.nix
  ];
}
