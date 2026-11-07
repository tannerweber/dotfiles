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
    myModNeovim.enable = lib.mkEnableOption "neovim modules";
  };

  config = lib.mkIf config.myModNeovim.enable {
    programs.neovim.enable = true;
    xdg.configFile."nvim/init.lua".source = mkSym "${dotDir}/.config/nvim/init.lua";

    # xdg.mimeApps = {
    #   enable = true;
    #   defaultApplications = {
    #     "text/*" = "nvim.desktop";
    #   };
    # };

    home.packages = with pkgs; [
      nixd
      tree-sitter
      imagemagick
      fd
    ];

    xdg.desktopEntries.nvim-text = {
      name = "Neovim Text";
      exec = "nvim %F";
      icon = "nvim";
      terminal = true;
      categories = [
        "Utility"
        "TextEditor"
        "Development"
      ];
      mimeType = [
        "text/english"
        "text/plain"
        "text/x-makefile"
        "text/x-c++hdr"
        "text/x-c++src"
        "text/x-chdr"
        "text/x-csrc"
        "text/x-java"
        "text/x-moc"
        "text/x-pascal"
        "text/x-tcl"
        "text/x-tex"
        "text/x-c"
        "text/x-c++"
        "text/x-nix"
        "text/x-rst"
        "text/x-python"
        "text/x-lua"
        "text/html"
        "text/org"
        "text/markdown"
        "text/x-shellscript"
        "application/toml"
        "image/png"
        "image/jpeg"
      ];
    };
  };
}
