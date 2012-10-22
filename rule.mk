host: hdirt h$(YIELD)

hdirt:
	@echo
	@echo Building $(NAME) on $(PLATFORM) for Host ...
	@mkdir hdirt

target: tdirt t$(YIELD)

tdirt:
	@echo
	@echo Building $(NAME) on $(PLATFORM) for Target ...
	@mkdir tdirt
	
hdirt/%.o : %.c
	@echo
	@echo Compiling $< source
	$(HCC_PATH)$(HT_PREFIX)$(WCC_PREFIX)gcc $(_FLAGS) $(CCFLAGS) $(CCDEFS) $(HCDEFS) $(IDIRS) -o"$@" "$<"

hdirt/%.o : %.cpp
	@echo
	@echo Compiling $< source
	$(HCC_PATH)$(HT_PREFIX)$(WCC_PREFIX)g++ -$(_FLAGS)  $(CCFLAGS) $(CCDEFS) $(HCDEFS) $(IDIRS) -o"$@" "$<"

tdirt/%.o : %.c
	@echo
	@echo Compiling $< source
	$(TCC_PATH)$(TT_PREFIX)gcc $(_FLAGS) $(CCFLAGS) $(CCDEFS) $(TCDEFS) $(IDIRS) -o"$@" "$<"

tdirt/%.o : %.cpp
	@echo
	@echo Compiling $< source
	$(TCC_PATH)$(TT_PREFIX)g++ $(_FLAGS) $(CCFLAGS) $(CCDEFS) $(TCDEFS) $(IDIRS) -o"$@" "$<"

hslib: $(HOBJECTS)
	@echo
	@echo Archiving into static library: libh-$(NAME).a
	$(HCC_PATH)$(HT_PREFIX)ar rcs libh-$(NAME).a $(HOBJECTS)

tslib: $(TOBJECTS)
	@echo
	@echo Archiving into static library: libh-$(NAME).a
	$(TCC_PATH)$(TT_PREFIX)ar rcs libt-$(NAME).a $(TOBJECTS)

hdlib: $(HOBJECTS)
	@echo
	@echo Archiving into dynamic library: libh-$(NAME).so
	$(HCC_PATH)$(HT_PREFIX)g++ libh-$(NAME).so $(HOBJECTS)

tdlib: $(TOBJECTS)
	@echo
	@echo Archiving into dynamic library: libh-$(NAME).so
	$(TCC_PATH)$(TT_PREFIX)g++ libt-$(NAME).so $(TOBJECTS)

hsload: $(HOBJECTS)
	@echo
	@echo Linking static load: $(NAME)
	$(HCC_PATH)$(HT_PREFIX)$(WCC_PREFIX)gcc $(LFLAGS) $(LDIRS) -o"h-$(NAME)" $(HOBJECTS) $(LHNAMES) $(LCNAMES)

tsload: $(TOBJECTS)
	@echo
	@echo Linking static load: $(NAME)
	$(TCC_PATH)$(TT_PREFIX)gcc $(LFLAGS) $(LDIRS) -o"t-$(NAME)" $(TOBJECTS) $(LTNAMES) $(LCNAMES)

hdload: $(HOBJECTS)
	@echo
	@echo Linking dynamic load: $(NAME)
	$(HCC_PATH)$(HT_PREFIX)$(WCC_PREFIX)g++ $(LFLAGS) $(LDIRS) -o"h-$(NAME)" $(HOBJECTS) $(LHNAMES) $(LCNAMES)

tdload: $(TOBJECTS)
	@echo
	@echo Linking dynamic load: $(NAME)
	$(TCC_PATH)$(TT_PREFIX)g++ $(LFLAGS) $(LDIRS) -o"t-$(NAME)" $(TOBJECTS) $(LTNAMES) $(LCNAMES)

vstudio:
	@echo
	$(VS_BUILDER) $(VS_BMODE) $(NAME).sln //property:Configuration=$(CONFIG)

cblocks:
	@echo
	$(CB_BUILDER) $(CB_BMODE) $(NAME).cbp

doxy:
	doxygen $(NAME).doxy

clean:
	@echo
	@echo Cleaning $(NAME) ...
	@echo
	rm -fr tdirt
	rm -fr hdirt
	rm -fr *-$(NAME)* *~
	@echo
	@echo Done
