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
      port = 9925;
    in
    lib.mkIf config.myModMealie.enable {
      networking.firewall.allowedTCPPorts = [ port ];
      services.mealie = {
        enable = true;
        listenAddress = "0.0.0.0:${toString port}";
        settings = {
          ALLOW_SIGNUP = "false";
        };
      };
    };
}
