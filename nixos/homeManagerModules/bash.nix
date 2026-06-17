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
    myModBash.enable = lib.mkEnableOption "bash modules";
  };

  config = lib.mkIf config.myModBash.enable {
    programs.bash = {
      enable = true;
      shellAliases = {
        ".." = "cd ..";
        "..." = "cd .. && cd ..";
        "cd" = "z";
        "c" = "clear";
        "d" = "eza -al --icons --group";
        "gs" = "git status";
        "gd" = "git diff";
        "gl" = "git log";
        "gc" = "git commit -m";
        "gb" = "git branch";
        "grv" = "git remote -v";
        "gad" = "git add .";
        "gau" = "git add -u";
        "gaa" = "git add -A";
        "n" = "nvim";
      };
      sessionVariables = {
        MANPAGER = "sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'";
      };
      initExtra = ''
        eval "$(fzf --bash)"
        eval "$(zoxide init bash)"
      '';
    };

  };
}
