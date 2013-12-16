SYS_XBUILD = xbuild

BUILDDIR:=$(OUTDIR)

Q		= $(if $(V),,@)
Q_MAKE		= $(if $(V),,-s)
Q_CC		= $(if $(V),,@echo "CC       $(notdir $(@))";)
RM		= $(Q)-rm
MKDIR		= $(Q)-mkdir -p
CP		= $(Q)-cp -f
MV		= $(Q)mv
TOUCH		= $(Q)touch
CHMOD		= $(Q)chmod
TAR		= $(Q)tar

MONO			= $(MONO_PATH)/bin/mono-sgen
MONO_ARGS		= --debug

MCS			= $(MONO_PATH)/bin/mcs

XBUILD_PROFILE_DIR	= $(MONO_PATH)/lib/mono/xbuild-frameworks

XBUILD_PROFILE_FLAG	= XBUILD_FRAMEWORK_FOLDERS_PATH=$(XBUILD_PROFILE_DIR)
XBUILD			= $(XBUILD_PROFILE_FLAG) $(MONO_PATH)/bin/xbuild

MDTOOL			= /Applications/Xamarin\ Studio.app/Contents/MacOS/mdtool

CONSOLE_XBUILD		= $(XBUILD) $(XBUILD_FLAGS)
ANDROID_XBUILD		= $(XBUILD) $(XBUILD_FLAGS)
