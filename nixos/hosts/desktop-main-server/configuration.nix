{
  inputs,
  pkgs,
  ...
}:

{
  myModLocality.enable = true;
  myModNvidia.enable = true;
  myModCliPrograms.enable = true;
  myModVim.enable = true;
  myModOpenSSH.enable = true;

  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "26.05";
  nixpkgs.config.allowUnfree = true;
  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Bootloader
  boot.loader.limine = {
    enable = true;
    secureBoot.enable = true;
    style.wallpapers = [ pkgs.nixos-artwork.wallpapers.stripes-logo.gnomeFilePath ];
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-0d16854e-1a91-4a83-b2ac-38082eda095a".device =
    "/dev/disk/by-uuid/0d16854e-1a91-4a83-b2ac-38082eda095a";

  networking = {
    hostName = "nixos-server";
    networkmanager.enable = true;
  };

  # Don't forget to set a password with ‘passwd’.
  users.users = {
    tannerw = {
      isNormalUser = true;
      description = "Tanner Weber";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.fish;
    };
  };
}
