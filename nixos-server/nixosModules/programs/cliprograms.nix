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
      fish = {
        enable = true;
        shellAbbrs = {
          "..." = "cd .. && cd ..";
          "c" = "clear";
          "d" = "ls -alFh --color";
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
          "gpom" = "git push origin main";
          "n" = "vim";
          "nsd" = "nix store diff-closures /nix/var/nix/profiles/system-";
        };
        interactiveShellInit = ''
          fish_hybrid_key_bindings
          set fish_cursor_default block
          set fish_cursor_visual block
          set fish_cursor_insert line
          set fish_cursor_external line
        '';
      };
      git.enable = true;
    };

    environment.systemPackages = with pkgs; [
      sbctl
      curl
      htop
      usbutils
    ];
  };
}
