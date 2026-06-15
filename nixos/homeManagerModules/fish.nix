{
  pkgs,
  lib,
  config,
  ...
}:

let
  dotDir = "/home/tannerw/.dotfiles";
in
{
  options = {
    myModFish.enable = lib.mkEnableOption "enables fish modules";
  };

  config = lib.mkIf config.myModFish.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -x LS_COLORS "di=1;33:*.o=0;34:*.txt=01;31"
        source ${dotDir}/.config/fish/abbrs.fish
        source ${dotDir}/.config/fish/binds.fish
        source ${dotDir}/.config/fish/my_completions.fish
        source ${dotDir}/.config/fish/programs.fish
        source ${dotDir}/.config/fish/greeting.fish
      '';
    };
  };
}
