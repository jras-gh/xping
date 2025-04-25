{
  description = "Xping probes multiple hosts using ICMP-ECHO";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  };

  outputs = { self, nixpkgs }: rec {
    packages.x86_64-linux.default = with import nixpkgs { system = "x86_64-linux"; };
    stdenv.mkDerivation {
      name = "xping";
      src = self;
      version = "1.4.2";
      buildInputs = [ openssl libevent ];
      installPhase = ''
        mkdir -p $out/bin
        mkdir -p $out/man8

        cp xping $out/bin
        cp xping-http $out/bin
        cp xping.8.gz $out/man8
        ln -f $out/man8/xping.8.gz $out/man8/xping-http.8.gz
      '';
    };

    packages.x86_64-linux.xping = packages.x86_64-linux.default;
  };
}
