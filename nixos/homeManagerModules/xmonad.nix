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
    myModXmonad.enable = lib.mkEnableOption "xmonad modules";
  };

  config = lib.mkIf config.myModXmonad.enable {
    xdg.configFile."picom/picom.conf".source = mkSym "${dotDir}/.config/picom/picom.conf" ;
    xdg.configFile."xmonad/xmonad.hs".source = mkSym "${dotDir}/.config/xmonad/xmonad.hs";
  };
}
