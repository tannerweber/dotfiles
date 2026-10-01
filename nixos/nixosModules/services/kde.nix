{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModKde.enable = lib.mkEnableOption "kde modules";
  };

  config = lib.mkIf config.myModKde.enable {
    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = with pkgs; [
      kdePackages.elisa
      kdePackages.kate
      kdePackages.gwenview
      kdePackages.okular
      kdePackages.ark
      kdePackages.discover
      kdePackages.plasma-systemmonitor
      kdePackages.qrca
      kdePackages.spectacle
      kdePackages.konsole
    ];
  };
}
