{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModOpenSSH.enable = lib.mkEnableOption "openssh modules";
  };

  config = lib.mkIf config.myModOpenSSH.enable {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        LogLevel = "VERBOSE";
        AllowUsers = [ "tannerw" ];
        MaxAuthTries = 5;
      };
    };
  };
}
