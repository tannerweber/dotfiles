{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ./bash.nix
    ./cliprograms.nix
    ./fish.nix
    ./neovim.nix
    ./sioyek.nix
    ./terminal.nix
  ];
}
