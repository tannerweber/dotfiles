{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModLy.enable = lib.mkEnableOption "ly modules";
  };

  config = lib.mkIf config.myModLy.enable {
    services.displayManager.ly = {
      enable = true;
      x11Support = true;
      settings = {
        clock = "%c";
      };
    };
  };
}
