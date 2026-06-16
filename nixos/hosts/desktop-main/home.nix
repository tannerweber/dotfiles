{
  pkgs,
  lib,
  config,
  ...
}@inputs:

let
  mkSym = config.lib.file.mkOutOfStoreSymlink;
  dotDir = "/home/tannerw/.dotfiles";
  ns = pkgs.writeShellApplication {
    name = "ns";
    runtimeInputs = with pkgs; [
      fzf
      nix-search-tv
    ];
    text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
  };
in
{
  myModBash.enable = true;
  myModFish.enable = true;

  home.username = "tannerw";
  home.homeDirectory = "/home/tannerw";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.nix-search-tv = {
    enable = true;
    enableTelevisionIntegration = true;
  };

  programs.zsh.enable = false;

  programs.git.enable = true;
  xdg.configFile."git/config".source = mkSym "${dotDir}/.config/git/config";

  programs.lazygit.enable = true;

  programs.starship.enable = true;
  xdg.configFile."starship.toml".source = mkSym "${dotDir}/.config/starship.toml";

  programs.eza.enable = true;
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.ripgrep.enable = true;
  programs.bat.enable = true;
  programs.yazi.enable = true;

  programs.neovim.enable = true;
  xdg.configFile."nvim/init.lua".source = mkSym "${dotDir}/.config/nvim/init.lua";

  programs.fastfetch.enable = true;
  programs.htop.enable = true;
  programs.btop.enable = true;
  programs.clock-rs.enable = true;

  programs.kitty.enable = true;
  xdg.configFile."kitty/kitty.conf".source = mkSym "${dotDir}/.config/kitty/kitty.conf";

  programs.wezterm.enable = true;
  xdg.configFile."wezterm/wezterm.lua".source = mkSym "${dotDir}/.config/wezterm/wezterm.lua";

  programs.ghostty.enable = false;
  xdg.configFile."ghostty/config".source = mkSym "${dotDir}/.config/ghostty/config";

  programs.sioyek.enable = true;

  programs.opencode.enable = true;
  programs.librewolf.enable = false;
  programs.dbeaver.enable = false;

  xdg.configFile."niri/config.kdl".source = mkSym "${dotDir}/.config/niri/config.kdl";
  xdg.configFile."rofi/config.rasi".source = mkSym "${dotDir}/.config/rofi/config.rasi";
  xdg.configFile."noctalia/colors.json".source = mkSym "${dotDir}/.config/noctalia/colors.json";
  xdg.configFile."noctalia/plugins.json".source = mkSym "${dotDir}/.config/noctalia/plugins.json";
  xdg.configFile."noctalia/settings.json".source = mkSym "${dotDir}/.config/noctalia/settings.json";
  xdg.configFile."gdb/gdbinit".source = mkSym "${dotDir}/.config/gdb/gdbinit";
  xdg.configFile."MangoHud/MangoHud.conf".source = mkSym "${dotDir}/.config/MangoHud/MangoHud.conf";

  home.packages = with pkgs; [
    ns
    nvtopPackages.nvidia

    curl
    wget
    mdfried
    filezilla

    nixd
    nixfmt

    typst
    tree-sitter

    galaxy-buds-client

    # Fonts
    nerd-fonts.hack

    # CLI Utils
    # dmidecode
    # lshw
  ];

  fonts.fontconfig.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "sioyek.desktop";
      "text/*" = "nvim.desktop";
    };
  };
}
