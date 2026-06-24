{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ./bash.nix
    ./cemu.nix
    ./cliprograms.nix
    ./fish.nix
    ./neovim.nix
    ./niri.nix
    ./sioyek.nix
    ./terminal.nix
    ./xmonad.nix
  ];
}
