################################################################################
#
# libgtk3
#
################################################################################

LIBGTK3_VERSION_MAJOR = 3.12
LIBGTK3_VERSION = $(LIBGTK3_VERSION_MAJOR).2

LIBGTK3_SOURCE = gtk+-$(LIBGTK3_VERSION).tar.xz
LIBGTK3_SITE = http://ftp.gnome.org/pub/gnome/sources/gtk+/$(LIBGTK3_VERSION_MAJOR)
LIBGTK3_LICENSE = LGPLv2+
LIBGTK3_LICENSE_FILES = COPYING
LIBGTK3_INSTALL_STAGING = YES
LIBGTK3_INSTALL_TARGET = YES

LIBGTK3_AUTORECONF = YES

LIBGTK3_CONF_ENV = ac_cv_func_posix_getpwuid_r=yes glib_cv_stack_grows=no \
		glib_cv_uscore=no \
		ac_cv_func_strtod=yes \
		ac_fsusage_space=yes \
		fu_cv_sys_stat_statfs2_bsize=yes \
		ac_cv_func_closedir_void=no \
		ac_cv_func_getloadavg=no \
		ac_cv_lib_util_getloadavg=no \
		ac_cv_lib_getloadavg_getloadavg=no \
		ac_cv_func_getgroups=yes \
		ac_cv_func_getgroups_works=yes \
		ac_cv_func_chown_works=yes \
		ac_cv_have_decl_euidaccess=no \
		ac_cv_func_euidaccess=no \
		ac_cv_have_decl_strnlen=yes \
		ac_cv_func_strnlen_working=yes \
		ac_cv_func_lstat_dereferences_slashed_symlink=yes \
		ac_cv_func_lstat_empty_string_bug=no \
		ac_cv_func_stat_empty_string_bug=no \
		vb_cv_func_rename_trailing_slash_bug=no \
		ac_cv_have_decl_nanosleep=yes \
		jm_cv_func_nanosleep_works=yes \
		gl_cv_func_working_utimes=yes \
		ac_cv_func_utime_null=yes \
		ac_cv_have_decl_strerror_r=yes \
		ac_cv_func_strerror_r_char_p=no \
		jm_cv_func_svid_putenv=yes \
		ac_cv_func_getcwd_null=yes \
		ac_cv_func_getdelim=yes \
		ac_cv_func_mkstemp=yes \
		utils_cv_func_mkstemp_limitations=no \
		utils_cv_func_mkdir_trailing_slash_bug=no \
		jm_cv_func_gettimeofday_clobber=no \
		gl_cv_func_working_readdir=yes \
		jm_ac_cv_func_link_follows_symlink=no \
		utils_cv_localtime_cache=no \
		ac_cv_struct_st_mtim_nsec=no \
		gl_cv_func_tzset_clobber=no \
		gl_cv_func_getcwd_null=yes \
		gl_cv_func_getcwd_path_max=yes \
		ac_cv_func_fnmatch_gnu=yes \
		am_getline_needs_run_time_check=no \
		am_cv_func_working_getline=yes \
		gl_cv_func_mkdir_trailing_slash_bug=no \
		gl_cv_func_mkstemp_limitations=no \
		ac_cv_func_working_mktime=yes \
		jm_cv_func_working_re_compile_pattern=yes \
		ac_use_included_regex=no gl_cv_c_restrict=no \
		ac_cv_path_GTK_UPDATE_ICON_CACHE=$(HOST_DIR)/usr/bin/gtk-update-icon-cache \
		ac_cv_path_GDK_PIXBUF_CSOURCE=$(HOST_DIR)/usr/bin/gdk-pixbuf-csource \
		ac_cv_prog_F77=no \
		ac_cv_path_CUPS_CONFIG=no

LIBGTK3_CONF_OPT = --disable-glibtest \
		--enable-explicit-deps=no \
		--enable-gtk2-dependency \
		--disable-debug

LIBGTK3_DEPENDENCIES = host-pkgconf host-libgtk3 libglib2 cairo pango atk \
		gdk-pixbuf

# Xorg dependencies
LIBGTK3_CONF_OPT += --with-x \
	--enable-x11-backend \
	--x-includes=$(STAGING_DIR)/usr/include/X11 \
	--x-libraries=$(STAGING_DIR)/usr/lib
LIBGTK3_DEPENDENCIES += fontconfig xlib_libX11 xlib_libXext xlib_libXrender \
		xlib_libXi at-spi2-atk

ifeq ($(BR2_PACKAGE_XLIB_LIBXINERAMA),y)
LIBGTK3_CONF_OPT += --enable-xinerama
LIBGTK3_DEPENDENCIES += xlib_libXinerama
else
LIBGTK3_CONF_OPT += --disable-xinerama
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXRANDR),y)
LIBGTK3_CONF_OPT += --enable-xrandr
LIBGTK3_DEPENDENCIES += xlib_libXrandr
else
LIBGTK3_CONF_OPT += --disable-xrandr
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXCURSOR),y)
LIBGTK3_DEPENDENCIES += xlib_libXcursor
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXFIXES),y)
LIBGTK3_CONF_OPT += --enable-xfixes
LIBGTK3_DEPENDENCIES += xlib_libXfixes
else
LIBGTK3_CONF_OPT += --disable-xfixes
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXCOMPOSITE),y)
LIBGTK3_CONF_OPT += --enable-xcomposite
LIBGTK3_DEPENDENCIES += xlib_libXcomposite
else
LIBGTK3_CONF_OPT += --disable-xcomposite
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXDAMAGE),y)
LIBGTK3_CONF_OPT += --enable-xdamage
LIBGTK3_DEPENDENCIES += xlib_libXdamage
else
LIBGTK3_CONF_OPT += --disable-xdamage
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXKBFILE),y)
LIBGTK3_CONF_OPT += --enable-xkb
LIBGTK3_DEPENDENCIES += xlib_libxkbfile
endif

ifeq ($(BR2_PACKAGE_CUPS),y)
LIBGTK3_CONF_OPT += --enable-cups
LIBGTK3_DEPENDENCIES += cups
else
LIBGTK3_CONF_OPT += --disable-cups
endif

ifeq ($(BR2_PACKAGE_LIBGTK3_DEMO),)
define LIBGTK3_POST_INSTALL_TWEAKS
	rm -rf $(TARGET_DIR)/usr/bin/gtk3-demo \
		$(TARGET_DIR)/usr/bin/gtk3-demo-application 
endef

LIBGTK3_POST_INSTALL_TARGET_HOOKS += LIBGTK3_POST_INSTALL_TWEAKS
endif

ifeq ($(BR2_PACKAGE_LIBGTK3_TESTS),y)
LIBGTK3_DEPENDENCIES += --enable-installed-tests
else
LIBGTK3_CONF_OPT += --disable-installed-tests
endif

# We do not build a full version of libgtk3 for the host, because that
# requires compiling Cairo, Pango, ATK and X.org for the
# host. Therefore, we patch it to remove dependencies, and we hack the
# build to only build gdk-pixbuf-from-source and
# gtk-update-icon-cache, which are the host tools needed to build Gtk
# for the target.

HOST_LIBGTK3_DEPENDENCIES = host-libglib2 host-libpng host-gdk-pixbuf

HOST_LIBGTK3_CFLAGS = $(shell $(HOST_DIR)/usr/bin/pkg-config \
	--cflags --libs gdk-pixbuf-2.0)

define HOST_LIBGTK3_CONFIGURE_CMDS
	echo "#define GETTEXT_PACKAGE \"gtk30\"" >> $(@D)/gtk/config.h
	echo "#define HAVE_UNISTD_H 1" >> $(@D)/gtk/config.h
	echo "#define HAVE_FTW_H 1" >> $(@D)/gtk/config.h
endef

define HOST_LIBGTK3_BUILD_CMDS
	$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) \
		$(@D)/gtk/updateiconcache.c \
		$(HOST_LIBGTK3_CFLAGS) \
		-o $(@D)/gtk/gtk-update-icon-cache
endef

define HOST_LIBGTK3_INSTALL_CMDS
	cp $(@D)/gtk/gtk-update-icon-cache $(HOST_DIR)/usr/bin
endef

$(eval $(autotools-package))
$(eval $(host-autotools-package))
