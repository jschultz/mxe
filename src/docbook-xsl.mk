# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := docbook-xsl
$(PKG)_WEBSITE  := http://docbook.sourceforge.net/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.79.1
$(PKG)_CHECKSUM := 725f452e12b296956e8bfb876ccece71eeecdd14b94f667f3ed9091761a4a968
$(PKG)_SUBDIR   := docbook-xsl-$($(PKG)_VERSION)
$(PKG)_FILE     := docbook-xsl-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := https://downloads.sourceforge.net/sourceforge/docbook/$($(PKG)_FILE)
$(PKG)_DEPS     := 

define $(PKG)_UPDATE
    echo 'TODO: write update script for $(PKG).' >&2;
    echo $($(PKG)_VERSION)
endef

define $(PKG)_BUILD
    $(INSTALL) -d -m755 '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    $(INSTALL) '$(SOURCE_DIR)'/catalog.xml '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    $(INSTALL) '$(SOURCE_DIR)'/VERSION '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    $(INSTALL) '$(SOURCE_DIR)'/VERSION.xsl '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    
    cd '$(SOURCE_DIR)' && $(INSTALL) catalog.xml '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cd '$(SOURCE_DIR)' && $(INSTALL) VERSION '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cd '$(SOURCE_DIR)' && $(INSTALL) VERSION.xsl '$(PREFIX)/$(TARGET)/share/xsl/docbook'

    cp -ar '$(SOURCE_DIR)'/assembly '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/common '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/eclipse '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/epub '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/epub3 '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/fo '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/highlighting '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/html '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/htmlhelp '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/images '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/javahelp '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/lib '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/manpages '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/params '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/profiling '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/roundtrip '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/template '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/slides '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/website '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/xhtml '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/xhtml-1_1 '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    cp -ar '$(SOURCE_DIR)'/xhtml5 '$(PREFIX)/$(TARGET)/share/xsl/docbook'
    
endef
