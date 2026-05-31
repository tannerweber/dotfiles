{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ./programs/niri.nix
    ./programs/vim.nix
    ./programs/zen-browser.nix
    ./services/kanata.nix
    ./services/rust-embedded-microbit.nix
  ];
}
