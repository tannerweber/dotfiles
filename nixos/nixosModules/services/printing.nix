{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModPrinting.enable = lib.mkEnableOption "printing modules";
  };

  config = lib.mkIf config.myModPrinting.enable {
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
        canon-cups-ufr2
      ];
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
