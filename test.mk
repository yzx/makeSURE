include env.mk

all:
	@echo
	@echo "Done"
	
bark:
	@echo
	@echo "Host platform - $(HPLAT)"
	@echo "Host fix      - $(HPLAT_FIX)"
	@echo "Host tools    - $(HTOOL_PREFIX)"
	@echo "Target tools  - $(TTOOL_PREFIX)"
	