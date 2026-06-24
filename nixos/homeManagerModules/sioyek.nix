{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModSioyek.enable = lib.mkEnableOption "sioyek modules";
  };

  config = lib.mkIf config.myModSioyek.enable {
    programs.sioyek = {
      enable = true;
      package = (
        pkgs.writeShellScriptBin "sioyek" ''
          exec env QT_QPA_PLATFORM=xcb ${pkgs.sioyek}/bin/sioyek "$@"
        ''
      );
      config = {
        background_color = "0.5 0.5 0.5";
        page_separator_width = "10";
        page_separator_color = "0.5 0.5 0.5";
      };
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "sioyek.desktop";
      };
    };

    xdg.desktopEntries.sioyek = {
      name = "Sioyek";
      exec = "env QT_QPA_PLATFORM=xcb sioyek %U";
      icon = "sioyek";
      terminal = false;
      categories = [
        "Office"
        "Viewer"
      ];
    };
  };
}
