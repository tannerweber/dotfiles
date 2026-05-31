# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  config,
  pkgs,
  ...
}:

{
  myModNiriDesktop.enable = true;
  myModVim.enable = true;
  myModZenBrowser.enable = true;
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
  boot.loader.systemd-boot.enable = true;
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

  # Locality
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  security.rtkit.enable = true;

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

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

  # Audio
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
    # media-session.enable = true;
  };

  services.flatpak.enable = true;

  xdg.mime.defaultApplications = {
    "application/pdf" = "zen.desktop";
    "text/*" = "nvim.desktop";
  };

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  ###################################### Users #################################
  # Don't forget to set a password with ‘passwd’.
  users.users.tannerw = {
    isNormalUser = true;
    description = "Tanner Weber";
    extraGroups = [
      "networkmanager"
      "wheel"
      "podman"
    ];
    shell = pkgs.fish;
  };

  ###################################### Programs ##############################
  programs = {
    bat.enable = true;
    fish.enable = true;
    lazygit.enable = true;
    neovim.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
    git.enable = true;
    starship.enable = true;
  };

  ###################################### Packages ##############################
  # To search run: nix search wget
  environment.systemPackages = [
    # Nix Utils
    pkgs.nixd
    pkgs.nixfmt

    # Language Stuff
    pkgs.typst
    pkgs.tree-sitter

    # Interactive CLI Programs
    pkgs.eza
    pkgs.fzf
    pkgs.btop
    pkgs.htop
    pkgs.fastfetch
    pkgs.opencode
    pkgs.starship
    pkgs.clock-rs
    pkgs.mdfried

    # CLI Utils
    pkgs.curl
    # dmidecode
    # lshw
    pkgs.ripgrep
    pkgs.wget

    # Other GUI Programs
    # dbeaver-bin
    pkgs.filezilla
    # ghostty
    pkgs.wezterm
    pkgs.kitty
    pkgs.bazaar
    pkgs.winboat
    # pkgs.librewolf
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
