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
    discord.enable = true;
  };

  home.packages = with pkgs; [
    mdfried
    filezilla
    typst
    galaxy-buds-client
    moonlight-qt
    brave
  ];

  xdg.configFile."niri/config.kdl".source = mkSym "${dotDir}/.config/niri/config_desktop_main.kdl";
  xdg.configFile."gdb/gdbinit".source = mkSym "${dotDir}/.config/gdb/gdbinit";
  xdg.configFile."MangoHud/MangoHud.conf".source = mkSym "${dotDir}/.config/MangoHud/MangoHud.conf";
}
