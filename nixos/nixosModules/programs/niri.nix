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
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    # securirty.pam.services.swaylock = { };
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
      xwayland-satellite
    ];
  };
}
