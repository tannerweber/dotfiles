{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModMiniflux.enable = lib.mkEnableOption "miniflux modules";
  };

  config = lib.mkIf config.myModMiniflux.enable {
    networking.firewall.allowedTCPPorts = [ 8080 ];
    services.miniflux = {
      enable = true;
      adminCredentialsFile = "/etc/nixos/secrets/miniflux-admin-credentials";
      config = {
        CREATE_ADMIN = false;
        LISTEN_ADDR = "0.0.0.0:8081"; # Default port 8080 conflicts with glance.
      };
    };
  };
}
