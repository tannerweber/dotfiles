# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  config,
  pkgs,
  ...
}:

{
  myModLocality.enable = true;
  myModCliPrograms.enable = true;
  myModNiriDesktop.enable = true;
  myModVim.enable = true;
  myModWinboat.enable = true;
  myModZenBrowser.enable = true;
  myModAudio.enable = true;
  myModFlatpak.enable = true;
  myModKanata.enable = true;
  myModLy.enable = true;
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
    secureBoot.enable = false;
    style.wallpapers = [ pkgs.nixos-artwork.wallpapers.stripes-logo.gnomeFilePath ];
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-22c9a714-cd66-4bfd-83c3-c87edb4d73c7".device =
    "/dev/disk/by-uuid/22c9a714-cd66-4bfd-83c3-c87edb4d73c7";

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # Desktop Environment
  services.desktopManager.plasma6.enable = true;

  # Scheduling
  services.system76-scheduler.enable = true;

  # Printing CUPS
  services.printing.enable = true;

  # Don't forget to set a password with ‘passwd’.
  users.users = {
    tannerw = {
      isNormalUser = true;
      description = "Tanner Weber";
      extraGroups = [
        "networkmanager"
        "wheel"
        "podman"
      ];
      shell = pkgs.fish;
    };
  };
}
