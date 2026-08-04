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
          "d" = "ls -al";
          "gs" = "git status";
          "gd" = "git diff";
          "gds " = "git diff --staged";
          "gl" = "git log";
          "gc" = "git commit -m";
          "gb" = "git branch";
          "grv" = "git remote -v";
          "gad" = "git add .";
          "gau" = "git add -u";
          "gaa" = "git add -A";
          "n" = "nvim";
        };
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
