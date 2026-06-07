{
  pkgs,
  lib,
  config,
  ...
}@inputs:

let
  mkSym = config.lib.file.mkOutOfStoreSymlink;
  dotDir = "/home/tannerw/.dotfiles";
in
{
  home.username = "tannerw";
  home.homeDirectory = "/home/tannerw";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

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

  programs.zsh.enable = false;

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

  programs.neovim.enable = true;
  xdg.configFile."nvim/init.lua".source = mkSym "${dotDir}/.config/nvim/init.lua";

  programs.fastfetch.enable = true;
  programs.htop.enable = true;
  programs.btop.enable = true;
  programs.clock-rs.enable = true;

  programs.kitty.enable = true;
  xdg.configFile."kitty/kitty.conf".source = mkSym "${dotDir}/.config/kitty/kitty.conf";

  programs.wezterm.enable = true;
  xdg.configFile."wezterm/wezterm.lua".source = mkSym "${dotDir}/.config/wezterm/wezterm.lua";

  programs.ghostty.enable = false;
  programs.opencode.enable = true;
  programs.librewolf.enable = false;
  programs.dbeaver.enable = false;

  home.packages = with pkgs; [
    curl
    wget
    mdfried
    filezilla

    nixd
    nixfmt

    typst
    tree-sitter

    # Fonts
    nerd-fonts.hack

    # CLI Utils
    # dmidecode
    # lshw
  ];

  fonts.fontconfig.enable = true;

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "zen.desktop";
    "text/*" = "nvim.desktop";
  };
}
