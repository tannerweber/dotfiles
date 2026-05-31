{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModNiriDesktop.enable = lib.mkEnableOption "enables niri modules";
  };

  config = lib.mkIf config.myModNiriDesktop.enable {
    programs.niri.enable = true;
    environment.systemPackages = with pkgs; [
      # waybar
      # quickshell
      noctalia-shell
      brightnessctl
      rofi
      # mako
      # swaylock
      # swayidle
      awww
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
      banana-cursor
    ];
  };
}
