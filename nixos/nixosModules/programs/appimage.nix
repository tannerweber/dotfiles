{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModAppImage.enable = lib.mkEnableOption "appimage modules";
  };

  config = lib.mkIf config.myModAppImage.enable {
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
