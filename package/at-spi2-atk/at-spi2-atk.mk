################################################################################
#
# at-spi2-atk
#
################################################################################

AT_SPI2_ATK_VERSION_MAJOR = 2.10
AT_SPI2_ATK_VERSION_MINOR = 2
AT_SPI2_ATK_VERSION = $(AT_SPI2_ATK_VERSION_MAJOR).$(AT_SPI2_ATK_VERSION_MINOR)
AT_SPI2_ATK_SOURCE = at-spi2-atk-$(AT_SPI2_ATK_VERSION).tar.xz
AT_SPI2_ATK_SITE = http://ftp.gnome.org/pub/gnome/sources/at-spi2-atk/$(AT_SPI2_ATK_VERSION_MAJOR)
AT_SPI2_ATK_LICENSE = LGPLv2+
AT_SPI2_ATK_LICENSE_FILES = COPYING
AT_SPI2_ATK_INSTALL_STAGING = YES
AT_SPI2_ATK_INSTALL_TARGET = YES

AT_SPI2_ATK_DEPENDENCIES = host-pkgconf libglib2 dbus atk at-spi2-core

$(eval $(autotools-package))
