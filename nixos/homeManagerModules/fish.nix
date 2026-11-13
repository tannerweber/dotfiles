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
    myModFish.enable = lib.mkEnableOption "fish modules";
  };

  config = lib.mkIf config.myModFish.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -x LS_COLORS "di=1;33:*.o=0;34:*.txt=01;31"
        set -x EDITOR "nvim"
        set -x LESSUTFCHARDEF "E000-F8FF:p,F0000-FFFFD:p,100000-10FFFD:p"
        source ${dotDir}/.config/fish/abbrs.fish
        source ${dotDir}/.config/fish/binds.fish
        source ${dotDir}/.config/fish/my_completions.fish
        source ${dotDir}/.config/fish/programs.fish
        source ${dotDir}/.config/fish/greeting.fish
      '';
    };
  };
}
