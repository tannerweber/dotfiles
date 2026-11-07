{
  pkgs,
  lib,
  config,
  ...
}:

let
  desktop = "re.sonny.Junction.desktop";
in
{
  options = {
    myModJunction.enable = lib.mkEnableOption "junction modules";
  };

  config = lib.mkIf config.myModJunction.enable {
    home.packages = [
      pkgs.junction
    ];
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/*" = desktop;
        "x-scheme-handler/http" = desktop;
        "x-scheme-handler/https" = desktop;
        "application/pdf" = desktop;
        "x-scheme-handler/file" = desktop;
        "image/png" = desktop;
        "image/jpeg" = desktop;
        "inode/directory" = desktop;
      };
    };

    xdg.desktopEntries.zen-pdf = {
      name = "Zen Browser PDF";
      exec = "zen --name zen %U";
      icon = "zen";
      terminal = false;
      categories = [
        "Office"
        "Viewer"
      ];
      mimeType = [
        "application/pdf"
      ];
    };
  };
}
