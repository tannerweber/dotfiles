{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModVirtManager.enable = lib.mkEnableOption "virt-manager modules";
  };

  config = lib.mkIf config.myModVirtManager.enable {
    # Don't forget to add users to the libvirtd group
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
  };
}
