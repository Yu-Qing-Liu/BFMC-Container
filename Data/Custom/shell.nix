with import <nixpkgs> {};
mkShell {
  name = "python env";
  buildInputs = with python312.pkgs; [
    pip
    pillow
    opencv4
    numpy
    setuptools
  ];
  shellHook = ''
    zsh
  '';
}
