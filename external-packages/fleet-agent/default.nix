{ stdenv
, lib
, zstd
, patchelf
, glibc
, openssl
, systemd
,
}:

stdenv.mkDerivation rec {
  pname = "fleet-osquery";
  version = "1.50.2";

  src = ./fleet-osquery-1.50.2-1-x86_64.pkg.tar.zst;

  nativeBuildInputs = [
    zstd
    patchelf
  ];

  unpackPhase = ''
    mkdir source
    cd source
    tar --use-compress-program=unzstd -xf $src
  '';

  installPhase = ''
    mkdir -p $out
    cp -r usr/* $out/
    cp -r etc $out/
    cp -r var $out/
    cp -r opt $out/
  '';

  postFixup = ''
    # Fix ELF interpreter + RPATH
    find $out -type f -executable | while read -r bin; do
      if patchelf --print-interpreter "$bin" >/dev/null 2>&1; then
        patchelf \
          --set-interpreter ${glibc.out}/lib/ld-linux-x86-64.so.2 \
          --set-rpath ${
            lib.makeLibraryPath [
              glibc
              openssl
              systemd
            ]
          } \
          "$bin"
      fi
    done
  '';

  dontStrip = true;

  meta = with lib; {
    description = "Fleet-managed osquery agent";
    platforms = platforms.linux;
  };
}
