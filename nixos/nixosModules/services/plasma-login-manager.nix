{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModPlasmaLoginManager.enable = lib.mkEnableOption "plasma login manager modules";
  };

  config = lib.mkIf config.myModPlasmaLoginManager.enable {
    services.displayManager = {
      plasma-login-manager.enable = true;
      autoLogin.user = "tannerw";
    };
    boot.initrd.systemd.enable = true;
    systemd.services.plasmalogin.serviceConfig.KeyringMode = "inherit";
    security.pam.services.plasmalogin-autologin.rules.auth = {
      systemd_loadkey = {
        order = 0;
        control = "optional";
        modulePath = "${pkgs.systemd}/lib/security/pam_systemd_loadkey.so";
      };
      plasmalogin = {
        order = 1;
        control = "include";
        modulePath = "plasmalogin";
      };
    };
  };
}
