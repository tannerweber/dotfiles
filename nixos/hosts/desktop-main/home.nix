{
  pkgs,
  lib,
  config,
  ...
}@inputs:

let
  mkSym = config.lib.file.mkOutOfStoreSymlink;
  dotDir = "/home/tannerw/.dotfiles";
in
{
  myModBash.enable = true;
  myModCliPrograms.enable = true;
  myModFish.enable = true;
  myModNeovim.enable = true;
  myModSioyek.enable = true;
  myModTerminal.enable = true;

  home.username = "tannerw";
  home.homeDirectory = "/home/tannerw";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

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
    mdfried
    filezilla

    typst

    galaxy-buds-client

    # CLI Utils
    # dmidecode
    # lshw
  ];

}
