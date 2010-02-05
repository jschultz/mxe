# This file is part of mingw-cross-env.
# See doc/index.html or doc/README for further information.

# GDAL
PKG             := gdal
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.7.0
$(PKG)_CHECKSUM := d45c59809b8c6051cd68ada5e55cd4f14aa4a092
$(PKG)_SUBDIR   := gdal-$($(PKG)_VERSION)
$(PKG)_FILE     := gdal-$($(PKG)_VERSION).tar.gz
$(PKG)_WEBSITE  := http://www.gdal.org/
$(PKG)_URL      := http://ftp.remotesensing.org/gdal/$($(PKG)_FILE)
$(PKG)_URL_2    := http://download.osgeo.org/gdal/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc zlib libpng tiff libgeotiff jpeg giflib expat curl geos

define $(PKG)_UPDATE
    wget -q -O- 'http://trac.osgeo.org/gdal/wiki/DownloadSource' | \
    $(SED) -n 's,.*gdal-\([0-9][^>]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        --host='$(TARGET)' \
        --disable-shared \
        --prefix='$(PREFIX)/$(TARGET)' \
        LIBS='-ljpeg' \
        --with-threads \
        --with-libz='$(PREFIX)/$(TARGET)' \
        --with-png='$(PREFIX)/$(TARGET)' \
        --with-libtiff='$(PREFIX)/$(TARGET)' \
        --with-geotiff='$(PREFIX)/$(TARGET)' \
        --with-jpeg='$(PREFIX)/$(TARGET)' \
        --with-gif='$(PREFIX)/$(TARGET)' \
        --with-expat='$(PREFIX)/$(TARGET)' \
        --with-curl='$(PREFIX)/$(TARGET)/bin/curl-config' \
        --with-geos='$(PREFIX)/$(TARGET)/bin/geos-config' \
        --without-python \
        --without-ngpython
    $(MAKE) -C '$(1)'       -j 1 lib-target
    $(MAKE) -C '$(1)'       -j 1 install-lib
    $(MAKE) -C '$(1)/port'  -j 1 install
    $(MAKE) -C '$(1)/gcore' -j 1 install
    $(MAKE) -C '$(1)/frmts' -j 1 install
    $(MAKE) -C '$(1)/alg'   -j 1 install
    $(MAKE) -C '$(1)/ogr'   -j 1 install OGR_ENABLED=
    $(MAKE) -C '$(1)/apps'  -j 1 install BIN_LIST=
endef
