{pkgs}: let
  python = pkgs.python3.withPackages (pythonPackages:
    with pythonPackages; [
      beautifulsoup4
      python-dateutil
      pyyaml
      requests
      strictyaml
    ]);
in
  pkgs.mkShell {
    packages = [
      pkgs.alejandra
      pkgs.bun
      pkgs.coreutils
      pkgs.curl
      pkgs.dnsutils
      pkgs.fd
      pkgs.ffmpeg
      pkgs.file
      pkgs.findutils
      pkgs.gawk
      pkgs.gh
      pkgs.git
      pkgs.htmlq
      pkgs.hunk
      pkgs.imagemagick
      pkgs.jq
      pkgs.lychee
      pkgs.nodejs
      pkgs.openssl
      pkgs.pandoc
      pkgs.pi-coding-agent
      pkgs.poppler-utils
      python
      pkgs.ripgrep
      pkgs.sqlite
      pkgs.unzip
      pkgs.xh
      pkgs.yq-go
    ];

    shellHook = ''
      if [[ $- == *i* ]]; then
        exec pi
      fi
    '';
  }
