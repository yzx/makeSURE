-include $(BUILD_BASE)/$(TOOL)/rule.mk

.PHONY: build
build: $(YIELD)
	@echo
	@echo Done
	@echo

.PHONY: dirt
dirt: bark
	@mkdir -p $(DIRT)

$(DIRT)/%.$(OX) : %.$(SX)
	@echo
	@echo Assembling $< source
	$(AS_RUN)

$(DIRT)/%.$(OX) : %.c
	@echo
	@echo Compiling $< C source
	$(CC_RUN)

lib: dirt $(OBJECTS)
	@echo
	@echo "Archiving into static library: $(LIB_PREFIX)$(NAME).$(SLX) ..."
	$(AR_RUN)
	@echo

app: dirt $(OBJECTS)
	@echo
	@echo "Linking application: $(NAME)$(LDX) ..."
	$(LD_RUN)
	@echo

.PHONY: clean
clean:
	@echo
	@echo "Cleaning dirt on $(HPLAT) at $(shell pwd) ..."
	@echo
	rm -fr $(PRJ_BASE)/*~ $(DIRT)
	@echo
	@echo "Done"
	@echo

.PHONY: yclean
yclean:
	@echo
	@echo "Cleaning $(NAME) on $(HPLAT) at $(shell pwd) ..."
	@echo
	rm -fr $(YNAME).*
	@echo
	@echo "Done"
	@echo

.PHONY: cpuclean
cpuclean:
	@echo
	@echo "Cleaning $(CPU) on $(HPLAT) at $(shell pwd) ..."
	@echo
	rm -fr $(CPU)
	@echo
	@echo "Done"
	@echo

.PHONY: distclean
distclean:
	@echo
	@echo "Cleaning ALL on $(HPLAT) at $(shell pwd) ..."
	@echo
	rm -fr $(DIRT_TOP)
	@echo
	@echo "Done"
	@echo

.PHONY: bark
bark:
	@echo
	@echo "Building $(NAME) on $(HPLAT) with $(TOOL) for $(CONFIG) at $(shell pwd) ..."

.PHONY: file
file:
	@echo
	@echo "File in $(shell pwd)"
	@echo "XML$(TAB)file - $(XMLFILES)"
	@echo "$(SX)$(TAB)file - $(SFILES)"
	@echo "$(AX)$(TAB)file - $(AFILES)"
	@echo "c$(TAB)file - $(CFILES)"
	@echo "cpp$(TAB)file - $(CPPFILES)"

.PHONY: env
env:
	@echo
	@echo "PATH - $(PATH)"

.PHONY: tool
tool:
	@echo
	@echo "$(AR)"

.PHONY: test
test:
	@echo
	@echo "user          - $(USERNAME)"
	@echo "os            - $(OS)"
	@echo
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

srec: app
	$(ECHO)
	$(ECHO) Preparing $@ image: $(NAME).$@
	$(OBJCOPY) -O $@ $(NAME).$(LDX) $(DEST)/$(NAME).$@

hex: app
	$(ECHO)
	$(ECHO) Preparing $@ image: $(NAME).$@
	$(OBJCOPY) -O i$@ $(NAME).$(LDX) $(DEST)/$(NAME).$@

bin: app
	$(ECHO)
	$(ECHO) Preparing $@ image: $(NAME).$@
	$(OBJCOPY) -O $@ary $(NAME).$(LDX) $(DEST)/$(NAME).$@

ldr: load
	$(ECHO)
	$(ECHO) Preparing $@ image: $(NAME).$@
	$(EL) $(NAME).dxe -b Flash -f HEX -Width 16 -init $(_BFHAL)/code/ldr/init_code_$(BF_PROCESSOR)/asm/Release/$(BF_PROCESSOR)_initcode.dxe -o $(NAME).ldr -NoInitCode -si-revision 0.3 -proc $(BF_PROCESSOR) -MM

-include $(BUILD_BASE)/$(TOOL)/rule.mk

	
