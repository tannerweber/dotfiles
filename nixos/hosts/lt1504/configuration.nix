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

  # FREEDOM
  nixpkgs.config.allowUnfree = true;
  # boot.kernelPackages = pkgs.linuxPackages_latest-libre;

  # Flakes Enable
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader
  boot.loader.limine = {
    enable = true;
    secureBoot.enable = true;
    style.wallpapers = [ pkgs.nixos-artwork.wallpapers.stripes-logo.gnomeFilePath ];
  };
  boot.loader.efi.canTouchEfiVariables = true;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16 GiB
    }
  ];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  security.rtkit.enable = true;

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

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
