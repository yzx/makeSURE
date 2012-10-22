include env.mk

all:
	@echo ""
	@echo "Done"
	@echo ""
	
bark:
	@echo ""
	@echo "Root prefix   - $(ROOT_PREFIX)"
	@echo "Home          - $(HOME)"
	@echo "Path          - $(PATH)"
	@echo ""
	@echo "Host platform - $(HPLAT)"
	@echo "Host fix      - $(HPLAT_FIX)"
	@echo "Host tools    - $(HTOOL_PREFIX)"
	@echo "Target tools  - $(TTOOL_PREFIX)"
	@echo ""
	