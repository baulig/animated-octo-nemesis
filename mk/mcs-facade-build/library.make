all:: $(FACADE_OUTPUT_DIR)/$(PROFILE)/$(LIBRARY)

net_4_5_FLAGS = -lib:$(MONO_PATH)/lib/mono/4.5

net_4_5_MCS = mcs
monodroid_MCS = $(MONODROID_PATH)/bin/smcs

$(FACADE_OUTPUT_DIR)/$(PROFILE)/$(LIBRARY): Makefile $(LIBRARY).sources
	@mkdir -p $(FACADE_OUTPUT_DIR)/$(PROFILE)
	$($(PROFILE)_MCS) -nostdlib $($(PROFILE)_FLAGS) -optimize -noconfig -target:library -out:$@ $(LIB_MCS_FLAGS) @$(LIBRARY).sources

	
