{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModJellyfin.enable = lib.mkEnableOption "jellyfin modules";
  };

  config = lib.mkIf config.myModJellyfin.enable {
    nixpkgs.config.cudaSupport = true;
    services.jellyfin = {
      enable = true;
      openFirewall = true;
      hardwareAcceleration = {
        enable = true;
        type = "nvenc";
        device = "/dev/dri/renderD128";
      };
    };
  };
}
