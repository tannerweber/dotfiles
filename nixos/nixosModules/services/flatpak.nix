{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModFlatpak.enable = lib.mkEnableOption "flatpak modules";
  };

  config = lib.mkIf config.myModFlatpak.enable {
    services.flatpak.enable = true;
    environment.systemPackages = with pkgs; [
      bazaar
    ];
  };
}
