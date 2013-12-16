THIS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

include $(THIS_DIR)../env.config

net_4_5_SUBDIRS = Facades

KEY_FILE = $(TOP)/Excalibur/Keys/b03f5f7f11d50a3a.pub

all: net_4_5 monodroid

net_4_5:
	$(MAKE) -C Facades MCS_BUILD_DIR=$(TOP)/mk/mcs-facade-build PROFILE=net_4_5 KEY_FILE=$(KEY_FILE)
	
monodroid:
	$(MAKE) -C Facades MCS_BUILD_DIR=$(TOP)/mk/mcs-facade-build PROFILE=monodroid KEY_FILE=$(KEY_FILE)

clean:
	rm -rf $(FACADE_OUTPUT_DIR)/net_4_5
	
.PHONY: all net_4_5 monodroid clean dist-default

include $(TOP)/mk/helper.mk

