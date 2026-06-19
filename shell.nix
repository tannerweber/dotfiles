{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  packages = with pkgs; [
    kdePackages.qtdeclarative

    lua-language-server
    stylua

    ghc
    haskell-language-server
    ormolu

    kdlfmt

    fish-lsp

    bash-language-server
  ];
}
