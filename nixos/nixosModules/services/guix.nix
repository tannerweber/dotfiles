{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModGuix.enable = lib.mkEnableOption "guix modules";
  };

  config = lib.mkIf config.myModGuix.enable {
    services.guix = {
      enable = true;
      gc = {
        enable = true;
        dates = "weekly";
      };
    };
  };
}
