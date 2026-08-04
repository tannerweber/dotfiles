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

  config = lib.mkIf config.myModGlance.enable {
    services.glance = {
      enable = true;
      openFirewall = true;
      settings = {
        server = {
          host = "0.0.0.0";
          port = 8080; # Default port 8080 conflicts with miniflux
        };
        pages = [
          {
            name = "Glance - Home";
            columns = [
              {
                size = "small";
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
                    ];
                  }
                ];
              }
              {
                size = "full";
                widgets = [
                  {
                    type = "to-do";
                  }
                ];
              }
              {
                size = "small";
                widgets = [
                  {
                    type = "calendar";
                  }
                  {
                    type = "weather";
                    units = "imperial";
                    location = "Portland, Oregon, United States";
                    show-area-name = true;
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
        theme = {
          background-color = "240 10 20";
          primary-color = "217 99 99";
          positive-color = "90 50 60";
          negative-color = "350 89 72";
          contrast-multiplier = 1.5;
          text-saturation-multiplier = 1;
        };
      };
    };
  };
}
