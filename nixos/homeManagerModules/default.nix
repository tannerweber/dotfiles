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
    ./sioyek.nix
  ];
}
