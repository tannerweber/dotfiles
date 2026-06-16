{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModSioyek.enable = lib.mkEnableOption "enables sioyek modules";
  };

  config = lib.mkIf config.myModSioyek.enable {
    programs.sioyek.enable = true;

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "sioyek.desktop";
      };
    };
  };
}
