THIS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
include $(THIS_DIR)../env.config

FRAMEWORK_FOLDERS_PATH=$(TEST_MONO_PATH)/lib/xbuild-frameworks

ANDROID_TARGETS_DIR=$(TEST_ANDROID_PATH)/lib/xbuild
ANDROID_FRAMEWORK_FOLDERS_PATH=$(FRAMEWORK_FOLDERS_PATH):$(TEST_ANDROID_PATH)/lib/xbuild-frameworks

define full_name
$(patsubst $(TEST_ROOT_DIR)/%,%,$(abspath $(1)))
endef

define wrench_report
	echo "@MonkeyWrench: AddSummary: <p>$(call full_name,$(2)) ($(1))"
endef

define error_report
	echo "@MonkeyWrench: AddSummary: <p>$(call full_name,$(2)) ($(1)) <span style='color: red;'>(failed)</span>"
endef

build_console:
	@echo "TEST_MONO_PATH: $(TEST_MONO_PATH)"
	@echo "XBUILD_FRAMEWORK_FOLDERS_PATH: $(FRAMEWORK_FOLDERS_PATH)"
	XBUILD_FRAMEWORK_FOLDERS_PATH=$(FRAMEWORK_FOLDERS_PATH) $(TEST_MONO_PATH)/bin/mono $(TEST_MONO_PATH)/lib/mono/4.5/xbuild.exe $(XBUILD_OPTIONS) /t:$(TARGET) /p:Configuration=$(CONFIG) $(PROJECT) || { $(call error_report,$(CONFIG),$(PROJECT)) ; exit 1; }
	$(call wrench_report,$(CONFIG),$(PROJECT))
	
run_console:
	$(TEST_MONO_PATH)/bin/mono $(OUTPUT) || { $(call error_report,$(CONFIG),$(PROJECT)) ; exit 1; }
	$(call wrench_report,$(CONFIG),$(PROJECT))

build_android:
	@echo "TEST_MONO_PATH: $(TEST_MONO_PATH)"
	echo "TEST_ANDROID_PATH: $(TEST_ANDROID_PATH)"
	@echo "XBUILD_FRAMEWORK_FOLDERS_PATH: $(ANDROID_FRAMEWORK_FOLDERS_PATH)"
	XBUILD_FRAMEWORK_FOLDERS_PATH=$(ANDROID_FRAMEWORK_FOLDERS_PATH) MSBuildExtensionsPath="$(TEST_ANDROID_PATH)/lib/xbuild" MONO_ANDROID_PATH="$(TEST_ANDROID_PATH)" $(TEST_MONO_PATH)/bin/mono $(TEST_MONO_PATH)/lib/mono/4.5/xbuild.exe $(XBUILD_OPTIONS) /t:$(TARGET) /p:Configuration=$(CONFIG) /p:MonoDroidInstallDirectory="$(TEST_ANDROID_PATH)" $(PROJECT) || { $(call error_report,$(CONFIG),$(PROJECT)) ; exit 1; }
	$(call wrench_report,$(CONFIG),$(PROJECT))
	
build_ios:
	$(TOP)/mk/ios-build.sh build -r:$(TEST_MONO_PATH) -t:$(TARGET) -c:$(CONFIG) $(PROJECT) || { $(call error_report,$(CONFIG),$(PROJECT)) ; exit 1; }
	$(call wrench_report,$(CONFIG),$(PROJECT))

.PHONY: build_console build_android build_ios
