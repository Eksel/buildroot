################################################################################
#
# midori
#
################################################################################

MIDORI_VERSION = 0.5.8
MIDORI_SOURCE = midori_$(MIDORI_VERSION)_all_.tar.bz2
MIDORI_SITE = http://midori-browser.org/downloads/
MIDORI_LICENSE = LGPLv2.1+
MIDORI_LICENSE_FILES = COPYING
MIDORI_DEPENDENCIES = \
	host-intltool \
	host-pkgconf \
	host-vala \
	libsoup \
	sqlite \
	libxml2 \
	webkit \
	$(if $(BR2_NEEDS_GETTEXT_IF_LOCALE),gettext)

MIDORI_CONF_OPT = -DUSE_ZEITGEIST=OFF

ifeq ($(BR2_PACKAGE_LIBGTK3),y)
# The actual WebKit logic in Buildroot enable webkit2 when WebKit uses GTK+3
MIDORI_CONF_OPT += \
	-DUSE_GTK3=ON \
	-DHALF_BRO_INCOM_WEBKIT2=ON
MIDORI_DEPENDENCIES += libgtk3
else
MIDORI_DEPENDENCIES += libgtk2
endif

define MIDORI_EXTRACT_CMDS
	$(call suitable-extractor,$(MIDORI_SOURCE)) $(DL_DIR)/$(MIDORI_SOURCE) \
		| $(TAR) $(TAR_STRIP_COMPONENTS)=0 -C $(@D) $(TAR_OPTIONS) -
endef

$(eval $(cmake-package))
