{
  pkgs,
  lib,
  config,
  ...
}:

let
  mkSym = config.lib.file.mkOutOfStoreSymlink;
  dotDir = "/home/tannerw/.dotfiles";
in
{
  options = {
    myModNeovim.enable = lib.mkEnableOption "enables neovim modules";
  };

  config = lib.mkIf config.myModNeovim.enable {
    programs.neovim.enable = true;
    xdg.configFile."nvim/init.lua".source = mkSym "${dotDir}/.config/nvim/init.lua";

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/*" = "nvim.desktop";
      };
    };

    home.packages = with pkgs; [
      nixd
      tree-sitter
    ];
  };
}
