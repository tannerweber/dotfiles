{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModCliPrograms.enable = lib.mkEnableOption "cli programs modules";
  };

  config = lib.mkIf config.myModCliPrograms.enable {
    programs = {
      fish.enable = true;
      git.enable = true;
    };

    environment.systemPackages = with pkgs; [
      sbctl
      curl
      htop
    ];
  };
}
