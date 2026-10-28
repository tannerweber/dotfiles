{
  pkgs,
  lib,
  config,
  ...
}:

let
  mkSym = config.lib.file.mkOutOfStoreSymlink;
  dotDir = "/home/tannerw/.dotfiles";
in
{
  myModBash.enable = true;
  myModCemu.enable = true;
  myModCliPrograms.enable = true;
  myModFish.enable = true;
  myModNeovim.enable = true;
  myModNiri.enable = true;
  myModSioyek.enable = true;
  myModTerminal.enable = true;
  myModXmonad.enable = true;

  home.username = "tannerw";
  home.homeDirectory = "/home/tannerw";
  home.stateVersion = "26.05";

  programs = {
    home-manager.enable = true;
    keepassxc.enable = true;
  };

  home.packages = with pkgs; [
    celluloid
    loupe
    gnome-obfuscate
    paper-clip

    signal-desktop
    kdePackages.kleopatra

    openvpn

    rnote
    wordbook
    gnome-calculator
    gnome-graphs
    hieroglyphic
    typst
    typstyle

    stm32cubemx
  ];

  xdg.configFile."niri/config.kdl".source = mkSym "${dotDir}/.config/niri/config_lt1504.kdl";
  xdg.configFile."gdb/gdbinit".source = mkSym "${dotDir}/.config/gdb/gdbinit";
}
