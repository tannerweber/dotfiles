{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModMealie.enable = lib.mkEnableOption "mealie modules";
  };

  config =
    let
      addr = "127.0.0.1";
      port = 9925;
      portLocal = port + 1;
    in
    lib.mkIf config.myModMealie.enable {
      services.mealie = {
        enable = true;
        listenAddress = "${addr}:${toString portLocal}";
        settings = {
          ALLOW_SIGNUP = "false";
        };
      };
      networking.firewall.allowedTCPPorts = [ port ];
      services.caddy.virtualHosts.":${toString port}".extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString portLocal}
      '';
    };
}
