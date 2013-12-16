THIS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

include $(THIS_DIR)../../env.config

all:: all-recurse

dist-default:

SUBDIRS = $($(PROFILE)_SUBDIRS)

SUBDIRS_MAKE= @target=`echo $@ | sed -e 's/-recurse//'` && \
	for dir in $(SUBDIRS); do\
		echo "Making $$target in $$dir";\
		$(MAKE) -C $$dir $$target || exit 1; \
	done
	       
all-recurse:
	$(SUBDIRS_MAKE)

.PHONY: all all-recurse dist-default

include $(TOP)/mk/helper.mk



