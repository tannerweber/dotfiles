{
  inputs,
  pkgs,
  ...
}:

{
  myModLocality.enable = true;
  myModCliPrograms.enable = true;
  myModNiriDesktop.enable = true;
  myModVim.enable = true;
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
    secureBoot.enable = true;
    style.wallpapers = [ pkgs.nixos-artwork.wallpapers.stripes-logo.gnomeFilePath ];
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-ea0ea4e6-9c37-4f62-a3b0-a728f149f085".device =
    "/dev/disk/by-uuid/ea0ea4e6-9c37-4f62-a3b0-a728f149f085";

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  programs.nix-ld.enable = true;

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
      ];
      shell = pkgs.fish;
    };
  };
}
