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
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "tannerw" ];
        MaxAuthTries = 3;
        LogLevel = "VERBOSE";
      };
    };
    services.fail2ban.enable = true;
  };
}
