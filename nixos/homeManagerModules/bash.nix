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
        "la" = "eza -al --icons --group";
        "d" = "eza -al --icons --group";
        "c" = "clear";
        "gs" = "git status";
        "gd" = "git diff";
        "gds " = "git diff --staged";
        "gl" = "git log";
        "gco" = "git commit -m";
        "gb" = "git branch";
        "gc" = "git checkout";
        "gcm" = "git checkout main";
        "grv" = "git remote -v";
        "gad" = "git add .";
        "gau" = "git add -u";
        "gaa" = "git add -A";
        "gwa" = "git worktree add";
        "gwr" = "git worktree remove";
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
