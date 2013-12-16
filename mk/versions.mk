.PHONY: check-versions reset-versions reset-ms-profiles

define get_module
  MODULE_$(2)=`grep 'git clone .*$(1).git' $(TOP)/README.md | awk -F' ' '{print $$$$4}'`
endef

define get_needed_version
  NEEDED_$(2)_VERSION=`grep 'cd $(1) .*hard' $(TOP)/README.md | awk -F' ' '{print $$$$8}'`
endef

define get_version
  $(2)_VERSION=`(cd $($(2)_PATH) && git log | head -1 | awk '{print $$$$2}')`
endef

define get_branch_and_remote
  $(2)_BRANCH_AND_REMOTE=`grep 'cd $(1) .*checkout' $(TOP)/README.md | awk -F' ' '{printf "%s %s",$$$$8,$$$$9}'`
endef

define get_needed_branch
  NEEDED_$(2)_BRANCH=`echo "$$$${$(2)_BRANCH_AND_REMOTE}" | sed -e 's, .*,,'`
endef

define get_branch
  $(2)_BRANCH=`(cd $($(2)_PATH) && git status | head -1 | awk '{print $$$$4}')`
endef


# usage $(call CheckVersionTemplate (mono,MONO))
define CheckVersionTemplate
#$(eval MODULE_$(2):=$(shell grep 'git clone .*$(1).git' $(TOP)/README.md | awk -F' ' '{print $$4}'))

#$(eval NEEDED_$(2)_VERSION:=$(shell grep 'cd $(1) .*hard' $(TOP)/README.md | awk -F' ' '{print $$8}'))
#$(eval $(2)_VERSION:=$(shell cd $($(2)_PATH) && git log | head -1 | awk '{print $$2}' ))

#$(eval $(2)_BRANCH_AND_REMOTE:=$(shell grep 'cd $(1) .*checkout' $(TOP)/README.md | awk -F' ' '{printf "%s %s",$$8,$$9}' ))
#$(eval NEEDED_$(2)_BRANCH:=$(word 1, $($(2)_BRANCH_AND_REMOTE)))
#$(eval $(2)_BRANCH:=$(shell cd $($(2)_PATH) && git status | head -1 | awk '{print $$4}' ))

check-$(1)::
	@if test x$$(IGNORE_$(2)_VERSION) = "x"; then \
	    if test ! -d $($(2)_PATH); then \
	        echo "Your $(1) checkout is missing, please run 'make reset-$(1)'"; \
	        touch .check-versions-failure; \
	    else \
	        $(call get_needed_version,$(1),$(2)); \
	        $(call get_version,$(1),$(2)); \
	        $(call get_branch_and_remote,$(1),$(2)); \
	        $(call get_needed_branch,$(1),$(2)); \
	        $(call get_branch,$(1),$(2)); \
	        if test `awk "BEGIN { print index (\"$$$${$(2)_VERSION}\",\"$$$${NEEDED_$(2)_VERSION}\") }"` = "0" -o \
	                `awk "BEGIN { print index (\"$$$${$(2)_BRANCH}\",\"$$$${NEEDED_$(2)_BRANCH}\") }"` = "0" ; then \
	            echo "Your $(1) version is out of date, please run 'make reset-$(1)'"; \
	            touch .check-versions-failure; \
	       fi; \
	    fi; \
	fi

reset-$(1)::
	@if test x$$(SKIP_RESET) = "x"; then \
		if test -z "$($(2)_PATH)"; then \
			echo "No directory specified for '$(1)'. Please re-run ./configure."; \
			exit 1; \
		fi; \
		if test -d $($(2)_PATH); then \
			if ! (cd $($(2)_PATH) && git show $(NEEDED_$(2)_VERSION)) >/dev/null 2>&1 ; then \
				echo "*** git fetch `basename $$($(2)_PATH)`" && (cd $($(2)_PATH) && git fetch); \
			fi;  \
		else \
			$(call get_module,$(1),$(2)); \
			echo "*** git clone $(MODULE_$(2))" && (cd `dirname $($(2)_PATH)` && git clone $(MODULE_$(2))); \
		fi; \
		       $(call get_branch_and_remote,$(1),$(2)); \
		$(call get_needed_branch,$(1),$(2)); \
		$(call get_needed_version,$(1),$(2)); \
		echo "*** git checkout" $(NEEDED_$(2)_BRANCH) && (cd $($(2)_PATH) ; git checkout $(NEEDED_$(2)_BRANCH) || git checkout -b $($(2)_BRANCH_AND_REMOTE)); \
		echo "*** git reset --hard $(NEEDED_$(2)_VERSION)" && (cd $($(2)_PATH) && git reset --hard $(NEEDED_$(2)_VERSION)); \
		echo "*** git submodule update --init --recursive" && (cd $($(2)_PATH) && git submodule update --init --recursive); \
	fi

.PHONY: check-$(1) reset-$(1)

reset-versions:: reset-$(1)
check-versions:: check-$(1)

endef

ifeq ($(CHECK_VERSIONS),all)
  $(shell rm -f .check-versions-failure)
  $(eval $(call CheckVersionTemplate,cecil,CECIL))
  $(eval $(call CheckVersionTemplate,binaries,MONO_PCL_BINARIES))
else
  ifneq ($(findstring cecil, $(CHECK_VERSIONS)),)
    $(eval $(call CheckVersionTemplate,cecil,CECIL))
  endif
  ifneq ($(findstring binaries, $(CHECK_VERSIONS)),)
    $(eval $(call CheckVersionTemplate,binaries,MONO_PCL_BINARIES))
  endif
endif

# some hackish reset-* targets to deal with what needs to happen in various parts of the build tree when you reset a module

reset-cecil::
	@if test x$(SKIP_RESET) = "x"; then \
		cd $(CECIL_PATH) && patch -i $(TOP)/cecil/assembly-rename.patch -p1; \
		cd $(CECIL_PATH) && $(SYS_XBUILD) /p:Configuration=net_4_0_Debug /t:Clean || exit 1; \
		cd $(CECIL_PATH) && $(SYS_XBUILD) /p:Configuration=net_4_0_Debug || exit 1; \
	fi
	
reset-binaries::
	@if test x$(SKIP_RESET) = "x"; then \
		cd $(OUTDIR) && rm -rf mono-pcl-xml ; \
		cd $(OUTDIR) && rm -rf mono-pcl-profiles ; \
		cd $(OUTDIR) && tar xzf $(MONO_PCL_BINARIES_PATH)/mono-pcl-xml.tar.gz || exit 1; \
	fi
	
reset-ms-profiles::
	@if test x$(SKIP_RESET) = "x" && test x$(MICROSOFT_PROFILE_PATH) != "x"; then \
		cd $(OUTDIR) && rm -rf $(MICROSOFT_PROFILE_DIRNAME) ; \
		cd $(OUTDIR) && tar xzf $(MICROSOFT_PROFILE_PATH) || exit 1; \
		mkdir -p $(PROFILE_OUTPUT_DIR) ; \
		cd $(OUTDIR) && mv $(MICROSOFT_PROFILE_DIRNAME) $(PROFILE_OUTPUT_DIR)/.NETPortable ; \
	fi

check-versions::
	@if test -e .check-versions-failure; then  \
		rm .check-versions-failure; \
		echo One or more modules needs update;  \
		exit 1; \
	else \
		echo All dependent modules up to date;  \
	fi

all-local:: check-versions

.NOTPARALLEL: check-versions reset-versions reset-ms-profiles
