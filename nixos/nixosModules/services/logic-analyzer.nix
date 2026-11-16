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
    programs.wireshark = {
      enable = true;
      usbmon.enable = true;
      dumpcap.enable = true;
    };
    hardware.ubertooth = {
      enable = true;
      group = "ubertooth";
    };
    hardware.hackrf = {
      enable = true;
    };
    hardware.rtl-sdr.enable = true;

    environment.systemPackages = with pkgs; [
      rtl-sdr
      rtl-sdr-blog
      rtl-sdr-librtlsdr
      rtl-sdr-osmocom

      hackrf
      sigrok-cli
      sigrok-firmware-fx2lafw
      pulseview
      tio
      i2c-tools
      openocd
      stlink-gui
      gcc-arm-embedded
      gqrx
      binwalk
      wireshark
      hashid
    ];
  };
}
