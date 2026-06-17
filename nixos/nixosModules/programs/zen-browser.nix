{
  pkgs,
  lib,
  config,
  ...
}@inputs:

{
  options = {
    myModZenBrowser.enable = lib.mkEnableOption "zen browser modules";
  };

  config = lib.mkIf config.myModZenBrowser.enable {
    environment.systemPackages = [
      inputs.inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
