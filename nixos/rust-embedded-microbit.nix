{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.udev = {
    enable = true;
    extraRules = ''
      # CMSIS-DAP for microbit
      ACTION!="add|change", GOTO="microbit_rules_end"
      SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", ATTR{idProduct}=="0204", TAG+="uaccess"
      LABEL="microbit_rules_end"
    '';
  };

  environment.systemPackages = with pkgs; [
    rustup
    gdb
    gcc
    gcc-arm-embedded
    usbutils
    probe-rs-tools
  ];
}
