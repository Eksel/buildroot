################################################################################
#
# webkit
#
################################################################################

WEBKIT_VERSION = 2.4.3
WEBKIT_SITE = http://www.webkitgtk.org/releases
WEBKIT_SOURCE = webkitgtk-$(WEBKIT_VERSION).tar.xz
WEBKIT_INSTALL_STAGING = YES
WEBKIT_DEPENDENCIES = host-ruby host-flex host-bison host-gperf enchant \
	harfbuzz icu jpeg libcurl libgail libsecret libsoup libxml2 libxslt \
	sqlite webp

WEBKIT_DEPENDENCIES += \
	$(if $(BR_PACKAGE_XLIB_LIBXCOMPOSITE),xlib_libXcomposite) \
	$(if $(BR_PACKAGE_XLIB_LIBXDAMAGE),xlib_libXdamage)

# Give explicit path to icu-config and prevent ar to make thin archives, fixing
# error: `x' cannot be used on thin archives
WEBKIT_CONF_ENV = ac_cv_path_icu_config=$(STAGING_DIR)/usr/bin/icu-config \
	AR_FLAGS="cru"

WEBKIT_CONF_OPT += \
	--disable-geolocation \
	--disable-glibtest \
	--disable-video \
	--disable-web-audio \
	--disable-gtk-doc-html

# X.org dependencies only
WEBKIT_CONF_OPT += --enable-x11-target
WEBKIT_DEPENDENCIES += xlib_libXt

ifeq ($(BR2_PACKAGE_LIBGTK3),y)
WEBKIT_CONF_OPT += \
	--with-gtk=3.0 \
	--enable-webkit2
WEBKIT_DEPENDENCIES += libgtk3
else
WEBKIT_CONF_OPT += \
	--with-gtk=2.0 \
	--disable-webkit2
WEBKIT_DEPENDENCIES += libgtk2
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
WEBKIT_CONF_OPT += --enable-glx
WEBKIT_DEPENDENCIES += libgl
else ifeq ($(BR2_PACKAGE_HAS_LIBEGL)$(BR2_PACKAGE_HAS_LIBGLES),yy)
WEBKIT_CONF_OPT += --enable-gles2
WEBKIT_DEPENDENCIES += libegl libgles
else
WEBKIT_CONF_OPT += \
	--disable-glx \
	--disable-gles2 \
	--disable-webgl \
	--disable-accelerated-compositing
endif

$(eval $(autotools-package))
