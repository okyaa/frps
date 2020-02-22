#
# Copyright (C) 2015-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=frps
PKG_VERSION:=0.31.2
PKG_RELEASE:=1

ifeq ($(ARCH),mipsel)
	frps_ARCH:=mipsle
endif
ifeq ($(ARCH),mips)
	frps_ARCH:=mips
endif
ifeq ($(ARCH),i386)
	frps_ARCH:=386
endif
ifeq ($(ARCH),x86_64)
	frps_ARCH:=amd64
endif
ifeq ($(ARCH),arm)
	frps_ARCH:=arm
endif
ifeq ($(ARCH),aarch64)
	frps_ARCH:=arm64
endif

PKG_LICENSE:=Apache-2.0

PKG_SOURCE_URL:=https://github.com/fatedier/frp/releases/download/v$(PKG_VERSION)
PKG_SOURCE:=frp_$(PKG_VERSION)_linux_$(frps_ARCH).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/frp_$(PKG_VERSION)_linux_$(frps_ARCH)
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=frps - fast reverse proxy Servers
	DEPENDS:=
	URL:=https://github.com/fatedier/frp/releases
endef



define Package/$(PKG_NAME)/description
frp is a fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet
endef

define Build/Prepare
	$(PKG_UNPACK)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/frps $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/frp/frps.d/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/frps_full.ini $(1)/etc/frp/frps.d/
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/frps.config $(1)/etc/config/frps
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/frps.init $(1)/etc/init.d/frps

endef




$(eval $(call BuildPackage,$(PKG_NAME)))
