{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ./locality.nix
    ./programs/niri.nix
    ./programs/vim.nix
    ./programs/winboat.nix
    ./programs/zen-browser.nix
    ./services/audio.nix
    ./services/flatpak.nix
    ./services/kanata.nix
    ./services/rust-embedded-microbit.nix
  ];
}
