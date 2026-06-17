{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModWinboat.enable = lib.mkEnableOption "winboat modules";
  };

  config = lib.mkIf config.myModWinboat.enable {
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
      };
    };
    environment.systemPackages = with pkgs; [
      winboat
    ];
  };
}
