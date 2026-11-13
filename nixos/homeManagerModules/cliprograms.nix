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
  updatix = pkgs.writeShellApplication {
    name = "updatix";
    text = ''
      arg1="$(find /nix/var/nix/profiles/ -maxdepth 1 -type l | sort -t- -k2,2nr | head -n 2 | sed -n '2p')"
      arg2="$(find /nix/var/nix/profiles/ -maxdepth 1 -type l | sort -t- -k2,2nr | head -n 1)"
      nix store diff-closures "$arg1" "$arg2"
    '';
  };
  rmarkdown-render = pkgs.writeShellApplication {
    name = "rmarkdown-render";
    text = ''
      echo "rmarkdown::render('$1')" | R --vanilla
    '';
  };
  nerdy-glyph-searcher =
    let
      name = "nerdy_glyph_searcher";
    in
    pkgs.rustPlatform.buildRustPackage {
      name = "nerdy_glyph_searcher";
      src = pkgs.fetchFromGitHub {
        owner = "tannerweber";
        repo = "nerdy_glyph_searcher";
        tag = "v0.1.0";
        hash = "sha256-ShQfWKywUvULVU7nxuVoO0OWAT1pUFahVzObBF9cpyM=";
      };
      cargoHash = "sha256-swujy+XczCK0Mhr79J9t9OPqr5QyP9o3v4LHrQutsGk=";

      nativeBuildInputs = [ pkgs.installShellFiles ];
      postInstall = ''
        installShellCompletion --cmd ${name} \
          --bash <($out/bin/${name} --shell-completion bash) \
          --fish <($out/bin/${name} --shell-completion fish) \
          --nushell <($out/bin/${name} --shell-completion nushell) \
          --zsh <($out/bin/${name} --shell-completion zsh)
        installManPage $releaseDir/build/${name}-*/out/${name}.1
      '';
    };
in
{
  options = {
    myModCliPrograms.enable = lib.mkEnableOption "cli programs modules";
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

    programs.tmux.enable = true;
    home.file.".tmux.conf".source = mkSym "${dotDir}/.tmux.conf";

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
      updatix
      rmarkdown-render
      nerdy-glyph-searcher
      curl
      wget
      nixfmt
      gnupg
      mdfried
    ];
  };
}
