{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModCaddy.enable = lib.mkEnableOption "caddy modules";
  };

  config = lib.mkIf config.myModCaddy.enable {
    networking.firewall.allowedTCPPorts = [
      80
      443
    ];
    services.caddy = {
      enable = true;
    };
  };
}
