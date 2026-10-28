{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModLogicAnalyzer.enable = lib.mkEnableOption "logic analyzer modules";
  };

  config = lib.mkIf config.myModLogicAnalyzer.enable {
    services.udev = {
      enable = true;
      packages = [ pkgs.libsigrok ];
    };

    environment.systemPackages = with pkgs; [
      sigrok-cli
      sigrok-firmware-fx2lafw
      pulseview
      tio
      i2c-tools
      openocd
      stlink-gui
    ];
  };
}
