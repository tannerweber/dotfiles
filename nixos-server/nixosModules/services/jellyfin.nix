{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModJellyfin.enable = lib.mkEnableOption "jellyfin modules";
  };

  config =
    let
      addr = "127.0.0.1"; # Set to not allow remote access in web interface.
      port = 8096;
      portLocal = port + 1; # Set in the Jellyfin web interface.
    in
    lib.mkIf config.myModJellyfin.enable {
      nixpkgs.config.cudaSupport = true;
      services.jellyfin = {
        enable = true;
        openFirewall = false;
        hardwareAcceleration = {
          enable = true;
          type = "nvenc";
          device = "/dev/dri/renderD128";
        };
      };
      # Add this proxy to known proxies in Jellyfin web interface.
      networking.firewall.allowedTCPPorts = [ port ];
      services.caddy.virtualHosts.":${toString port}".extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString portLocal}
      '';
    };
}
