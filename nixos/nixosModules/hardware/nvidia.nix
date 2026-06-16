{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModNvidia.enable = lib.mkEnableOption "enables nvidia module";
  };

  config = lib.mkIf config.myModNvidia.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    hardware.nvidia = {
      open = true; # Use open module drivers.
      modesetting.enable = true;
    };
    services.xserver.videoDrivers = [ "nvidia" ]; # Don't use nouveau drivers.

    environment.systemPackages = with pkgs; [
      nvtopPackages.nvidia
    ];
  };
}
