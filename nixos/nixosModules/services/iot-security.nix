{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModIotSecurity.enable = lib.mkEnableOption "iot security modules";
  };

  config = lib.mkIf config.myModIotSecurity.enable {
    services.udev = {
      enable = true;
      packages = [ pkgs.libsigrok ];
    };
    programs.wireshark = {
      enable = true;
      usbmon.enable = true;
      dumpcap.enable = true;
    };
    programs.tcpdump = {
      enable = true;
    };
    programs.ghidra = {
      enable = true;
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
      rtl_433
      rtl-sdr-blog
      rtl-sdr-librtlsdr
      rtl-sdr-osmocom

      urh
      cubicsdr
      python3
      tcpdump
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
      inspectrum
    ];
  };
}
