{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ./programs/vim.nix
    ./programs/zen-browser.nix
    ./services/kanata.nix
    ./services/rust-embedded-microbit.nix
  ];
}
