{ stdenv
, lib
, patchelf
, glibc
, openssl
,
}:

let
  pkgver = "7.32.0";
  pkgrel = "18504";
in
stdenv.mkDerivation {
  pname = "falcon-sensor";
  version = "${pkgver}-${pkgrel}";

  src = ./falcon-sensor_7.32.0-18504_amd64.deb;

  nativeBuildInputs = [
    patchelf
  ];

  unpackPhase = ''
    ar x $src
    tar -xf data.tar.xz
  '';

  installPhase = ''
    mkdir -p $out/usr/lib/
    mv lib/* $out/usr/lib/

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
            ]
          } \
          "$bin"
      fi
    done
  '';

  meta = with lib; {
    description = "CrowdStrike Falcon Sensor for Linux";
    platforms = platforms.linux;
    homepage = "https://falcon.crowdstrike.com/";
  };
}
