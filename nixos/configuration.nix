# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Flakes Enable
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
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

  security = {
    pam.services.swaylock = {};
    rtkit.enable = true;
    polkit.enable = true;
  };

  services = {
    # UDEV
    udev = {
      enable = true;
      extraRules =
      ''
        # CMSIS-DAP for microbit
	ACTION!="add|change", GOTO="microbit_rules_end"
        SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", ATTR{idProduct}=="0204", TAG+="uaccess"
        LABEL="microbit_rules_end"
      '';
    };
  
    # X11 windowing system.
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      # Enable touchpad support (enabled default in most desktopManager).
      # libinput.enable = true;
    };

    # Desktop Environment.
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;
    system76-scheduler.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;
    pulseaudio.enable = false;
    gnome.gnome-keyring.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;
      #media-session.enable = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tannerw = {
    isNormalUser = true;
    description = "Tanner Weber";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
    shell = pkgs.fish;
  };

  programs = {
    firefox.enable = true;
    bat.enable = true;
    fish.enable = true;
    neovim.enable = true;
    niri.enable = true;
    vim.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
    git.enable = true;
    starship.enable = true;
    waybar.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Desktop Environment
    brightnessctl
    fuzzel
    mako
    swaylock
    swayidle
    swaybg
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk

    # Interactive CLI Programs
    eza
    fzf
    btop
    htop
    fastfetch
    opencode
    starship

    # CLI Utils
    curl
    wget
    ripgrep

    # Rust
    rustup
    gdb
    gcc
    gcc-arm-embedded
    usbutils
    probe-rs-tools

    # Other GUI Programs
    dbeaver-bin
    filezilla
    ghostty
    wezterm
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
