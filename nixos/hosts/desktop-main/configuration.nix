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
  myModNvidia.enable = true;
  myModGaming.enable = true;
  myModNiriDesktop.enable = true;
  myModVim.enable = true;
  myModWinboat.enable = true;
  myModZenBrowser.enable = true;
  myModAudio.enable = true;
  myModFlatpak.enable = true;
  myModKanata.enable = true;

  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "26.05";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader
  # boot.loader.limine = {
  #   enable = true;
  #   secureBoot.enable = true;
  # style.wallpapers = [ pkgs.nixos-artwork.wallpapers.stripes-logo.gnomeFilePath ];
  # };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-0d16854e-1a91-4a83-b2ac-38082eda095a".device = "/dev/disk/by-uuid/0d16854e-1a91-4a83-b2ac-38082eda095a";

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  hardware.bluetooth.enable = true;

  # Display Manager
  services.displayManager.ly = {
    enable = true;
    x11Support = false;
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

  programs = {
    fish.enable = true;
    git.enable = true;
  };

  environment.systemPackages = [
    pkgs.sbctl
    pkgs.curl
    pkgs.htop
  ];
}
