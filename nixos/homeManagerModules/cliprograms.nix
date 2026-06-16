{
  pkgs,
  lib,
  config,
  ...
}:

let
  mkSym = config.lib.file.mkOutOfStoreSymlink;
  dotDir = "/home/tannerw/.dotfiles";
  ns = pkgs.writeShellApplication {
    name = "ns";
    runtimeInputs = with pkgs; [
      fzf
      nix-search-tv
    ];
    text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
  };
in
{
  options = {
    myModCliPrograms.enable = lib.mkEnableOption "enables cli programs modules";
  };

  config = lib.mkIf config.myModCliPrograms.enable {
    programs.nix-search-tv = {
      enable = true;
      enableTelevisionIntegration = true;
    };

    programs.git.enable = true;
    xdg.configFile."git/config".source = mkSym "${dotDir}/.config/git/config";

    programs.lazygit.enable = true;

    programs.starship.enable = true;
    xdg.configFile."starship.toml".source = mkSym "${dotDir}/.config/starship.toml";

    programs.eza.enable = true;
    programs.fzf.enable = true;
    programs.zoxide.enable = true;
    programs.ripgrep.enable = true;
    programs.bat.enable = true;
    programs.yazi.enable = true;

    programs.fastfetch.enable = true;
    programs.htop.enable = true;
    programs.btop.enable = true;
    programs.clock-rs.enable = true;

    home.packages = with pkgs; [
      ns
      curl
      wget
      nixfmt
    ];
  };
}
