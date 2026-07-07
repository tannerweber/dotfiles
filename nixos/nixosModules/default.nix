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
    ./programs/gaming.nix
    ./programs/niri.nix
    ./programs/vim.nix
    ./programs/winboat.nix
    ./programs/zen-browser.nix
    ./services/audio.nix
    ./services/flatpak.nix
    ./services/kanata.nix
    ./services/ly.nix
    ./services/openssh.nix
    ./services/rust-embedded-microbit.nix
    ./services/xmonad.nix
  ];
}
