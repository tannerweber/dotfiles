{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModCemu.enable = lib.mkEnableOption "cemu modules";
  };

  config = lib.mkIf config.myModCemu.enable {
    home.packages = with pkgs; [
      cemu-ti
    ];

    xdg.desktopEntries.cemu = {
      name = "CEmu";
      exec = "CEmu";
      categories = [
        "Office"
        "Education"
      ];
    };
  };
}
