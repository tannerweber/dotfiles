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
    myModTerminal.enable = lib.mkEnableOption "enables terminal modules";
  };

  config = lib.mkIf config.myModTerminal.enable {
    programs.wezterm.enable = true;
    xdg.configFile."wezterm/wezterm.lua".source = mkSym "${dotDir}/.config/wezterm/wezterm.lua";

    programs.kitty.enable = true;
    xdg.configFile."kitty/kitty.conf".source = mkSym "${dotDir}/.config/kitty/kitty.conf";

    programs.ghostty.enable = false;
    xdg.configFile."ghostty/config".source = mkSym "${dotDir}/.config/ghostty/config";

    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      nerd-fonts.hack
    ];
  };
}
