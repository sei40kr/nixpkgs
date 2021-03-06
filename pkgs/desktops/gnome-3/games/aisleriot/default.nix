{ stdenv, fetchurl, pkgconfig, gnome3, intltool, itstool, gtk3
, wrapGAppsHook, librsvg, libxml2, desktop-file-utils
, guile_2_0, libcanberra-gtk3 }:

stdenv.mkDerivation rec {
  pname = "aisleriot";
  version = "3.22.9";

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${stdenv.lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "0yzdh9cw5cjjgvfh75bihl968czlgfmpmn1z0fdk88sgvpjgzwji";
  };

  configureFlags = [
    "--with-card-theme-formats=svg"
    "--with-platform=gtk-only" # until they remove GConf
  ];

  nativeBuildInputs = [ pkgconfig intltool itstool wrapGAppsHook libxml2 desktop-file-utils ];
  buildInputs = [ gtk3 librsvg guile_2_0 libcanberra-gtk3 ];

  passthru = {
    updateScript = gnome3.updateScript {
      packageName = pname;
      attrPath = "gnome3.${pname}";
    };
  };

  meta = with stdenv.lib; {
    homepage = "https://wiki.gnome.org/Apps/Aisleriot";
    description = "A collection of patience games written in guile scheme";
    maintainers = teams.gnome.members;
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
