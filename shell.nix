{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs.buildPackages; [ 
    cargo
    gnumake
    nodejs_22
    zola
  ];
}
