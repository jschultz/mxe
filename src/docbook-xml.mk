# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := docbook-xml
$(PKG)_WEBSITE  := http://www.oasis-open.org/docbook/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.5
$(PKG)_CHECKSUM := 4e4e037a2b83c98c6c94818390d4bdd3f6e10f6ec62dd79188594e26190dc7b4
$(PKG)_SUBDIR   := 
$(PKG)_FILE     := docbook-xml-$($(PKG)_VERSION).zip
$(PKG)_URL      := http://www.oasis-open.org/docbook/xml/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := 

define $(PKG)_UPDATE
    echo 'TODO: write update script for $(PKG).' >&2;
    echo $($(PKG)_VERSION)
endef

define $(PKG)_BUILD
    $(INSTALL) -d -m755 '$(PREFIX)/$(TARGET)/share/xml/docbook/$($(PKG)_VERSION)'
    $(INSTALL) $(SOURCE_DIR)/*\.* '$(PREFIX)/$(TARGET)/share/xml/docbook/$($(PKG)_VERSION)'
    $(INSTALL) -d -m755 '$(PREFIX)/$(TARGET)/share/xml/docbook/$($(PKG)_VERSION)/ent'
    $(INSTALL) $(SOURCE_DIR)/ent/* '$(PREFIX)/$(TARGET)/share/xml/docbook/$($(PKG)_VERSION)/ent'
endef
