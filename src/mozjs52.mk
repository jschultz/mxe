# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := mozjs52
$(PKG)_WEBSITE  := http://www.freedesktop.org/wiki/Software/mozjs52
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 52.9.0
$(PKG)_CHECKSUM := c01d09658c53c1b3a496e353a24dad03b26b81d3b1d099abc26a06f81c199dd6
$(PKG)_SUBDIR   := firefox-$($(PKG)_VERSION)esr
$(PKG)_FILE     := firefox-$($(PKG)_VERSION)esr.source.tar.xz
$(PKG)_URL      := http://ftp.mozilla.org/pub/firefox/releases/$($(PKG)_VERSION)esr/source/$($(PKG)_FILE)
$(PKG)_DEPS     := cc glib icu4c libffi nspr zlib readline

define $(PKG)_UPDATE
    echo 'TODO: write update script for $(PKG).' >&2;
    echo $($(PKG)_VERSION)
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(BUILD_DIR)' && SHELL=/bin/bash PYTHON=/usr/bin/python2 CC=$(HOME)/mxe/usr/bin/i686-w64-mingw32.static-gcc '$(SOURCE_DIR)'/configure \
        --target='$(TARGET)' \
        --prefix='$(PREFIX)/$(TARGET)' \
		--disable-jemalloc --disable-optimize --enable-ctypes \
		--enable-pie --enable-readline \
		--enable-shared-js --enable-system-ffi --enable-tests \
		--with-intl-api \
		--enable-nspr-build
#		--with-system-icu --with-system-nspr --with-system-zlib
    $(MAKE) -C '$(1)' -j '$(JOBS)' bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    $(MAKE) -C '$(1)' -j 1 install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
