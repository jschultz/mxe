# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libjpeg-turbo
$(PKG)_WEBSITE  := https://libjpeg-turbo.virtualgl.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.0.1
$(PKG)_CHECKSUM := e5f86cec31df1d39596e0cca619ab1b01f99025a27dafdfc97a30f3a12f866ff
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://$(SOURCEFORGE_MIRROR)/project/$(PKG)/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc yasm

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://sourceforge.net/projects/$(PKG)/files/' | \
    $(SED) -n 's,.*/projects/.*/\([0-9][^"%]*\)/".*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DENABLE_STATIC=$(CMAKE_STATIC_BOOL) \
        -DCMAKE_INSTALL_BINDIR='$(PREFIX)/$(TARGET)/bin/$(PKG)' \
        -DCMAKE_INSTALL_INCLUDEDIR='$(PREFIX)/$(TARGET)/include/$(PKG)' \
        -DCMAKE_INSTALL_LIBDIR='$(PREFIX)/$(TARGET)/lib/$(PKG)' \
        -DCMAKE_ASM_NASM_COMPILER=$(TARGET)-yasm
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    '$(TARGET)-gcc' \
        -W -Wall -Werror -ansi -pedantic \
        '$(TOP_DIR)/src/jpeg-test.c' -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' \
        `'$(TARGET)-pkg-config' '$(PREFIX)/$(TARGET)/lib/$(PKG)/pkgconfig/libjpeg.pc' --cflags --libs`
endef
