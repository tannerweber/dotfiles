# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./kanata.nix
  ];

  # FREEDOM
  nixpkgs.config.allowUnfree = true;
  # boot.kernelPackages = pkgs.linuxPackages_latest-libre;

  # Flakes Enable
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;

    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
  };

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
    pam.services.swaylock = { };
    rtkit.enable = true;
    polkit.enable = true;
  };

  services = {
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

    # Display Manager
    displayManager.ly = {
      enable = true;
      x11Support = false;
    };

    # Desktop Environment
    desktopManager.plasma6.enable = true;

    # Scheduling
    system76-scheduler.enable = true;

    # Enable CUPS to print documents
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

  xdg.mime.defaultApplications = {
    "application/pdf" = "zen.desktop";
    "text/*" = "nvim.desktop";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tannerw = {
    isNormalUser = true;
    description = "Tanner Weber";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = [
      #  pkgs.thunderbird
    ];
    shell = pkgs.fish;
  };

  programs = {
    bat.enable = true;
    fish.enable = true;
    lazygit.enable = true;
    neovim.enable = true;
    niri.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
    git.enable = true;
    starship.enable = true;
  };

  programs.vim = {
    enable = true;
    defaultEditor = true;
    package = (pkgs.vim-full.override { }).customize {
      name = "vim";
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [
          vim-nix
        ];
        opt = [ ];
      };
      vimrcConfig.customRC = ''
        let g:netrw_banner=0
        let g:netrw_liststyle=3
        filetype plugin indent on
        syntax enable

        set confirm
        set colorcolumn=81
        set mouse=a
        set tabstop=4
        set shiftwidth=4
        set number
        set relativenumber
        set cursorline
        set guicursor="n-v-c:block-blinkwait1000-blinkon1000-blinkoff1,i-ci-ve:ver25-Cursor,r-cr-o:hor20"
        set completeopt="fuzzy,menu,menuone,noinsert,noselect,popup,preview"
        set termguicolors
        set scrolloff=10
        set ignorecase
        set smartcase
        set signcolumn="yes"
        set list
        set listchars=tab:»\ ,trail:.
        set splitright
        set splitbelow
        set updatetime=250
        set timeoutlen=300

        set laststatus=2
        set wrap
        set hlsearch
        set statusline=%F\ %m\ %=\ %y\ [%p\%%\ %l\:%c]
        set wildmenu
        set wildmode=list:longest
        colorscheme catppuccin
        set background=dark

        let &t_SI = "\e[6 q"
        let &t_EI = "\e[1 q"
        augroup myCmds
        au!
        autocmd VimEnter * silent !echo -ne "\e[1 q"
        augroup END
      '';
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Desktop Environment
    pkgs.waybar
    pkgs.brightnessctl
    pkgs.rofi
    pkgs.mako
    pkgs.swaylock
    pkgs.swayidle
    pkgs.awww
    pkgs.xdg-desktop-portal-gnome
    pkgs.xdg-desktop-portal-gtk

    # Nix Utils
    pkgs.nixd
    pkgs.nixfmt

    # Language Stuff
    pkgs.lua-language-server
    pkgs.stylua
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
    # pkgs.librewolf
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

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
