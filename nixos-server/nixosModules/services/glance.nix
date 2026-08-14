{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModGlance.enable = lib.mkEnableOption "glance modules";
  };

  config =
    let
      addr = "127.0.0.1";
      port = 8080;
      portLocal = port + 1;
    in
    lib.mkIf config.myModGlance.enable {
      services.glance = {
        enable = true;
        openFirewall = false;
        settings = {
          server = {
            host = addr;
            port = portLocal;
          };
        };
      };
      services.glance.settings.pages = [
        {
          name = "Glance - Home";
          columns = [
            {
              size = "full";
              widgets = [
                {
                  type = "server-stats";
                  servers = [
                    {
                      type = "local";
                      hide-mountpoints-by-default = true;
                      mountpoints = {
                        "/" = {
                          hide = false;
                        };
                      };
                    }
                  ];
                }
                {
                  type = "monitor";
                  sites = [
                    {
                      title = "Jellyfin";
                      url = "http://127.0.0.1:8096";
                    }
                    {
                      title = "Mealie";
                      url = "http://127.0.0.1:9925";
                    }
                  ];
                }
                {
                  type = "clock";
                  hour-format = "12h";
                }
              ];
            }
          ];
        }
      ];
      services.glance.settings.theme = {
        background-color = "240 10 20";
        primary-color = "217 99 99";
        positive-color = "90 50 60";
        negative-color = "350 89 72";
        contrast-multiplier = 1.5;
        text-saturation-multiplier = 1;
      };
      networking.firewall.allowedTCPPorts = [ port ];
      services.caddy.virtualHosts.":${toString port}".extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString portLocal}
      '';
    };
}
