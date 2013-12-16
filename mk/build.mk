include $(TOP)/mk/helper.mk
include $(TOP)/mk/rules.mk

CONFIGURATIONS = Debug Release

TEST_ROOT_DIR ?= $(TOP)

#
# The actual build commands
#

run_command = $(MAKE) $(MAKE_FLAGS) -f $(TOP)/mk/build-commands.mk TEST_ROOT_DIR=$(TEST_ROOT_DIR) PROJECT=$(1) CONFIG=$(2) TARGET=$(3) $(4) $(5)

project_output = $(if $($(1)_CONSOLE_EXE),$(call $(1)_CONSOLE_EXE,$(1),$(2)),$(1)/bin/$(2)/$(1).exe)
run_console_command = $(call run_command,$(4),$(3),Run,run_console,OUTPUT=$(call project_output,$(basename $(4)),$(3)))

#
# Helper functions
#

define run_build
	@rm -f .success-$(1)-$(2).$(3)
	@touch .stamp-$(1)-$(2).$(3)
	$(call run_command,$(3),$(2),Build,build_$(1))
	@touch .success-$(1)-$(2).$(3)
endef

run_clean = $(call run_command,$(4),$(3),Clean) ; rm -f .stamp-$(2)-$(3).$(4) .success-$(2)-$(3).$(4)

stamp_subst = $(patsubst %.sln,.$(1)-$(2)-$(3).%.sln,$($(2)_SOLUTIONS))

foreach_config = $(foreach config,$(CONFIGURATIONS),$(call $(1),$(2),$(3),$(config)))

foreach_stamp = $(foreach file,$(call stamp_subst,$(1),$(2),$(3)),@if test -f $(file); then $(call $(4),$(1),$(2),$(3),$(patsubst .$(1)-$(2)-$(3).%,%,$(file))); fi ;)

define stamp_rule
$(call stamp_subst,stamp,$(1),$(2)): .stamp-$(1)-$(2).% : %
	echo $(call run_build,$(1),$(2),$$*)
endef

define stamp_config_rule
$(foreach config,$(CONFIGURATIONS),$(eval $(call stamp_rule,$(1),$(config))))
endef

define target_template
$(eval $(call stamp_config_rule,$(1)))

$(1):: $(call foreach_config,stamp_subst,stamp,$(1))

.PHONY: $(1)
endef

define clean_target_config_template
clean-$(1)-$(2)::
	$(call foreach_stamp,stamp,$(1),$(2),run_clean)
	
clean-$(1):: clean-$(1)-$(2)

clean:: clean-$(1)

.PHONY: clean-$(1)-$(2) clean-$(1)
endef
define clean_target_template
$(foreach config,$(CONFIGURATIONS),$(eval $(call clean_target_config_template,$(1),$(config))))
endef

define extra_target_config_template
$(2)-$(1):: $(1)
	$(call foreach_stamp,success,$(1),$(3),$(2)_$(1)_command)
	
$(2):: $(2)-$(1)

.PHONY: $(2)-$(1) $(2)
endef

define extra_target_template
$(foreach config,$(CONFIGURATIONS),$(eval $(call extra_target_config_template,$(1),$(2),$(config))))
endef

#
# Console
#

$(eval $(call target_template,console))
$(eval $(call extra_target_template,console,run))
$(eval $(call clean_target_template,console))

#
# Android
#

$(eval $(call target_template,android))
$(eval $(call clean_target_template,android))

#
# iOS
#

$(eval $(call target_template,ios))
$(eval $(call clean_target_template,ios))

