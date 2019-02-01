# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := polkit
$(PKG)_WEBSITE  := http://www.freedesktop.org/wiki/Software/polkit
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.115
$(PKG)_CHECKSUM := 2f87ecdabfbd415c6306673ceadc59846f059b18ef2fce42bac63fe283f12131
$(PKG)_SUBDIR   := polkit-$($(PKG)_VERSION)
$(PKG)_FILE     := polkit-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := http://freedesktop.org/software/polkit/releases/$($(PKG)_FILE)
$(PKG)_DEPS     := cc glib

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://freedesktop.org/software/polkit/releases/' | \
    $(SED) -n 's,.*polkit-\([0-9][^>]*\)\.tar.*,\1,p' | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)'/configure \
        $(MXE_CONFIGURE_OPTS) \
        --host='$(TARGET)' \
        --disable-introspection \
        --disable-systemd \
	--disable-libsystemd-login \
	--disable-libelogind \
	--disable-static \
	--with-authfw=pam  \
	--with-os-type=void \
	--without-mozjs
    $(MAKE) -C '$(1)' -j '$(JOBS)' bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    $(MAKE) -C '$(1)' -j 1 install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
