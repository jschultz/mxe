# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qtmacextras
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt
$(PKG)_IGNORE   :=
$(PKG)_VERSION   = $(qtbase_VERSION)
$(PKG)_CHECKSUM := 3ea0b94f9b63e801f2ddafa2a908002d9529a3c65021d261627d21e07454acde
$(PKG)_SUBDIR    = $(subst qtbase,qtmacextras,$(qtbase_SUBDIR))
$(PKG)_FILE      = $(subst qtbase,qtmacextras,$(qtbase_FILE))
$(PKG)_URL       = $(subst qtbase,qtmacextras,$(qtbase_URL))
$(PKG)_DEPS     := cc qtbase qtdeclarative qtmultimedia

define $(PKG)_UPDATE
    echo $(qtbase_VERSION)
endef

define $(PKG)_BUILD
    cd '$(1)' && '$(PREFIX)/$(TARGET)/qt5/bin/qmake'
#         -after \
#         'LIBS_PRIVATE += -lgdi32'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
