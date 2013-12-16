# subdir handling ala automake, but without dealing with auto*

all:: all-local all-recurse all-hook
build:: build-local build-recurse build-hook
clean:: clean-local clean-recurse clean-hook
install:: install-local install-recurse install-hook
uninstall:: uninstall-local uninstall-recurse uninstall-hook

console:: console-local console-recurse console-hook
run:: run-local run-recurse run-hook
ios:: ios-local ios-recurse ios-hook
android:: android-local android-recurse android-hook

all-local::
build-local::
clean-local::
install-local::
uninstall-local::
console-local::
run-local::
ios-local::
android-local::

all-hook::
build-hook::
clean-hook::
install-hook::
uninstall-hook::
console-hook::
run-hook::
ios-hook::
android-hook::

ifeq ($(SUBDIRS),)
all-recurse:
build-recurse:
clean-recurse:
install-recurse:
uninstall-recurse:
console-recurse:
run-recurse:
ios-recurse:
android-recurse:
else
SUBDIRS_MAKE= @target=`echo $@ | sed -e 's/-recurse//'` && \
	       for dir in $(SUBDIRS); do	\
		echo "Making $$target in $$dir";\
		$(MAKE) -C $$dir $$target || exit 1; \
	       done

all-recurse:
	$(SUBDIRS_MAKE)
	
build-recurse:
	$(SUBDIRS_MAKE)

clean-recurse:
	$(SUBDIRS_MAKE)

install-recurse:
	$(SUBDIRS_MAKE)

uninstall-recurse:
	$(SUBDIRS_MAKE)
	
console-recurse:
	$(SUBDIRS_MAKE)
	
run-recurse:
	$(SUBDIRS_MAKE)
	
ios-recurse:
	$(SUBDIRS_MAKE)
	
android-recurse:
	$(SUBDIRS_MAKE)
endif

.PHONY: all clean install uninstall all-local clean-local install-local uninstall-local all-hook clean-hook install-hook uninstall-hook all-recurse clean-recurse install-recurse uninstall-recurse
.PHONY: build build-local build-hook build-recurse
.PHONY: console console-local console-hook console-recurse
.PHONY: run run-local run-hook run-recurse
.PHONY: ios ios-local ios-hook ios-recurse
.PHONY: android android-local android-hook android-recurse

include $(TOP)/mk/helper.mk
