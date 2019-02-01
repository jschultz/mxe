# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := nspr
$(PKG)_WEBSITE  := http://www.freedesktop.org/wiki/Software/mozjs52
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.20
$(PKG)_CHECKSUM := 2c8964913da89ffbaf464d49ce44d79e8804e1794ef9a8c52a7bff7224d1556e
$(PKG)_SUBDIR   := nspr-$($(PKG)_VERSION)
$(PKG)_FILE     := nspr-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://ftp.mozilla.org/pub/nspr/releases/v$($(PKG)_VERSION)/src/$($(PKG)_FILE)
$(PKG)_DEPS     := cc zlib

define $(PKG)_UPDATE
    echo 'TODO: write update script for $(PKG).' >&2;
    echo $($(PKG)_VERSION)
endef

define $(PKG)_BUILD
#     CFLAGS="$CFLAGS -D_PR_POLL_AVAILABLE -D_PR_HAVE_OFF64_T -D_PR_INET6 -D_PR_HAVE_INET_NTOP -D_PR_HAVE_GETHOSTBYNAME2 -D_PR_HAVE_GETADDRINFO -D_PR_INET6_PROBE"

#     cd '$(SOURCE_DIR)'/'$(PKG)' && autoreconf -fi'
    cd '$(BUILD_DIR)' && SHELL=/bin/bash PYTHON=/usr/bin/python2 CC=$(HOME)/mxe/usr/bin/i686-w64-mingw32.static-gcc '$(SOURCE_DIR)'/'$(PKG)'/configure \
        --target='$(TARGET)' \
        --prefix='$(PREFIX)/$(TARGET)' \
		--enable-optimize \
		--enable-debug
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
