include $(TOP)/mk/rules.mk

subdirs:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $(TARGET) || exit 1; \
	done

.PHONY: subdirs

