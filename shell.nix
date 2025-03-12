{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    hugo
    awscli
    terraform
    terraform-ls
  ];
}

