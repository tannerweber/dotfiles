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
  options = {
    myModNiri.enable = lib.mkEnableOption "niri modules";
  };

  config = lib.mkIf config.myModNiri.enable {
    xdg.configFile."niri/config.kdl".source = mkSym "${dotDir}/.config/niri/config.kdl";
    xdg.configFile."rofi/config.rasi".source = mkSym "${dotDir}/.config/rofi/config.rasi";
    xdg.configFile."noctalia/colors.json".source = mkSym "${dotDir}/.config/noctalia/colors.json";
    xdg.configFile."noctalia/plugins.json".source = mkSym "${dotDir}/.config/noctalia/plugins.json";
    xdg.configFile."noctalia/settings.json".source = mkSym "${dotDir}/.config/noctalia/settings.json";
  };
}
