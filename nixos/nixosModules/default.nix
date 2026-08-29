{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ./programs/cliprograms.nix
    ./programs/gaming.nix
    ./programs/niri.nix
    ./programs/virt-manager.nix
    ./programs/winboat.nix
    ./programs/zen-browser.nix
    ./services/audio.nix
    ./services/flatpak.nix
    ./services/guix.nix
    ./services/kanata.nix
    ./services/ly.nix
    ./services/rust-embedded-microbit.nix
    ./services/sunshine.nix
    ./services/xmonad.nix
  ];
}
