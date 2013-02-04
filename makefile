ALL:
	@echo
	$(MAKE) -f prj.mk YIELD="" build
	@echo
	@echo "$@ done in $(shell pwd)"

$(MAKECMDGOALS):
	$(MAKE) -f prj.mk CONFIG=Debug $(MAKECMDGOALS)

