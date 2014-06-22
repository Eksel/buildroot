################################################################################
#
# at-spi2-core
#
################################################################################

AT_SPI2_CORE_VERSION_MAJOR = 2.10
AT_SPI2_CORE_VERSION_MINOR = 2
AT_SPI2_CORE_VERSION = $(AT_SPI2_CORE_VERSION_MAJOR).$(AT_SPI2_CORE_VERSION_MINOR)
AT_SPI2_CORE_SOURCE = at-spi2-core-$(AT_SPI2_CORE_VERSION).tar.xz
AT_SPI2_CORE_SITE = http://ftp.gnome.org/pub/gnome/sources/at-spi2-core/$(AT_SPI2_CORE_VERSION_MAJOR)
AT_SPI2_CORE_LICENSE = LGPLv2+
AT_SPI2_CORE_LICENSE_FILES = COPYING
AT_SPI2_CORE_INSTALL_STAGING = YES
AT_SPI2_CORE_INSTALL_TARGET = YES
AT_SPI2_CORE_AUTORECONF = YES

AT_SPI2_CORE_CONF_OPT = --disable-introspection \
			--disable-xevie

AT_SPI2_CORE_DEPENDENCIES = host-pkgconf libglib2 dbus xlib_libXi xlib_libXtst \
		host-intltool

$(eval $(autotools-package))
