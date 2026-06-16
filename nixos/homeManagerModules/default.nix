{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ./bash.nix
    ./fish.nix
    ./neovim.nix
    ./sioyek.nix
  ];
}
