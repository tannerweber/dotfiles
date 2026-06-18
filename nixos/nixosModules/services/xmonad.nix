{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModXmonad.enable = lib.mkEnableOption "xmonad module";
  };

  config = lib.mkIf config.myModXmonad.enable {
    services.picom.enable = true;
    services.xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
      windowManager = {
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
          extraPackages = hpkgs: [
            hpkgs.xmonad
            hpkgs.xmonad-extras
            hpkgs.xmonad-contrib
          ];
        };
      };
    };
  };
}
