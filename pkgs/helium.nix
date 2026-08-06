{ lib, stdenv, fetchurl, dpkg, autoPatchelfHook, wrapGAppsHook3
, gtk3, glib, nss, nspr, atk, cups, dbus, expat, libdrm
, libX11, libXcomposite, libXdamage, libXext, libXfixes, libXrandr
, mesa, libxkbcommon, pango, cairo, alsa-lib
, at-spi2-atk, at-spi2-core }:

stdenv.mkDerivation rec {
  pname = "helium";
  version = "0.15.2.1";

  src = fetchurl {
    url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-bin_${version}-1_amd64.deb";
    sha256 = "sha256-nrHfQmImxN2X/EiyQAnxHdCs7luozofrPD54jcfce6w=";
  };

  nativeBuildInputs = [ dpkg autoPatchelfHook wrapGAppsHook3 ];

  buildInputs = [
    gtk3 glib nss nspr atk cups dbus expat libdrm
    libX11 libXcomposite libXdamage libXext libXfixes libXrandr
    mesa libxkbcommon pango cairo alsa-lib
    at-spi2-atk at-spi2-core
  ];

  unpackPhase = ''
    dpkg-deb --fsys-tarfile $src | tar x --no-same-permissions --no-same-owner
  '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/opt/helium
    cp -r opt/helium/* $out/opt/helium/
    ln -s $out/opt/helium/helium $out/bin/helium
    mkdir -p $out/share
    cp -r usr/share/* $out/share/ 2>/dev/null || true

    # Fix desktop file to use binary name instead of hardcoded path
    substituteInPlace $out/share/applications/helium.desktop \
      --replace "Exec=/usr/bin/helium" "Exec=helium"
  '';

  meta = {
    description = "Helium - private, fast, and honest web browser based on Chromium";
    homepage = "https://helium.computer";
    license = lib.licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "helium";
  };
}
