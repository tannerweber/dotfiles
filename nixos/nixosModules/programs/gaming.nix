{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModGaming.enable = lib.mkEnableOption "gaming modules";
  };

  config = lib.mkIf config.myModGaming.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    environment.systemPackages = with pkgs; [
      mangohud
      lutris
    ];

    programs.gamemode.enable = true;
  };
}
