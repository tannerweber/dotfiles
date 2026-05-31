{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModAudio.enable = lib.mkEnableOption "enables audio module";
  };

  config = lib.mkIf config.myModAudio.enable {
    services = {
      pulseaudio.enable = false;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # jack.enable = true;
        # media-session.enable = true;
      };
    };
  };
}
