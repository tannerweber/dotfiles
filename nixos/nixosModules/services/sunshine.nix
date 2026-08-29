{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModSunshine.enable = lib.mkEnableOption "sunshine modules";
  };

  config = lib.mkIf config.myModSunshine.enable {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}
