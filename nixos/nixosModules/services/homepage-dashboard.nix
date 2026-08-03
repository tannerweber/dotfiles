{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModHomepageDashboard.enable = lib.mkEnableOption "homepage-dashboard modules";
  };

  config = lib.mkIf config.myModHomepageDashboard.enable {
    services.homepage-dashboard = {
      enable = true;
      openFirewall = true;
      allowedHosts = "*"; # Don't restrict who can connect.
      settings = {
        title = "Homepage";
      };
      widgets = [
        {
          resources = {
            cpu = true;
            memory = true;
            uptime = true;
          };
        }
      ];
    };
  };
}
