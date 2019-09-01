# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := qttools
$(PKG)_WEBSITE  := https://www.qt.io/
$(PKG)_DESCR    := Qt
$(PKG)_IGNORE   :=
$(PKG)_VERSION   = $(qtbase_VERSION)
$(PKG)_CHECKSUM := 3b0e353860a9c0cd4db9eeae5f94fef8811ed7d107e3e5e97e4a557f61bd6eb6
$(PKG)_SUBDIR    = $(subst qtbase,qttools,$(qtbase_SUBDIR))
$(PKG)_FILE      = $(subst qtbase,qttools,$(qtbase_FILE))
$(PKG)_URL       = $(subst qtbase,qttools,$(qtbase_URL))
$(PKG)_DEPS     := cc qtactiveqt qtbase qtdeclarative
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)

$(PKG)_TEST_DIR := $(dir $(lastword $(MAKEFILE_LIST)))/qttools-test

define $(PKG)_UPDATE
    echo $(qtbase_VERSION)
endef

define $(PKG)_BUILD
    cd '$(1)' && '$(PREFIX)/$(TARGET)/qt5/bin/qmake'
    OSXCROSS_XCRUN_NO_ENV_WARNING=1 $(MAKE) -C '$(1)' -j '$(JOBS)'
    OSXCROSS_XCRUN_NO_ENV_WARNING=1 $(MAKE) -C '$(1)' -j 1 install

    # test QUiLoader
    mkdir '$(1)'.test
    cd '$(1)'.test && '$(TARGET)-cmake' '-DCMAKE_TOOLCHAIN_FILE=$(PREFIX)/$(TARGET)/share/cmake/mxe-conf.cmake' '$($(PKG)_TEST_DIR)'
    $(MAKE) -C '$(1)'.test
    cp '$(1)'.test/mxe-cmake-qtuitools \
        '$(PREFIX)/$(TARGET)/bin/test-qttools'
endef

define $(PKG)_BUILD_$(BUILD)
    cd '$(1)' && '$(PREFIX)/$(TARGET)/qt5/bin/qmake'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
