AS=      AX51
CC=      C51
AR=      LIBX51
LD=      LX51
OH=      Ohx51

AX=      a51
CX=      c
OX=      obj
LSX=     lst
SLX=     LIB
MPX=     map
APX=     OMF
OHX=     ihx


ifneq ($(CONFIG),Release)
# Debug and all others
CONFIG_AS_FLAGS= DB
CONFIG_DEF?= DEBUG
CONFIG_CC_FLAGS=  OT"(2, Size)"
CONFIG_LD_FLAGS=
else
CONFIG_AS_FLAGS=
CONFIG_DEF?= NDEBUG
CONFIG_CC_FLAGS=  OT"(8, Size)"
CONFIG_LD_FLAGS=
endif

ifneq ($(CCDEF) $(CONFIG_DEF),)
CCDEFS= DF"($(subst $(space),$(SPACE), $(call inject-comma,$(CCDEF) $(CONFIG_DEF) )))"
endif

ifneq ($(IDIR),)
IDIRS= INCDIR"($(subst $(space),$(SPACE), $(call inject-comma,$(IDIR))))"
endif

TCFLAGS= PR"($(DIRT)/"$*".$(LSX))" $(IDIRS) $(CCDEFS) OJ"("$@")"

ASFLAGS= NOCO MACRO CASE EP $(CONFIG_AS_FLAGS) $(TCFLAGS)

CCFLAGS= NOIV LARGE MODDP2 OMF2 CD DB NOIP VB"(1)" $(CONFIG_CC_FLAGS) $(TCFLAGS)

LDFLAGS= PR"($(DIRT_PREFIX)/$(NAME).$(MPX))" IX CODE DW"(16)" RU \
CL"(XDATA(X:0x0000-X:0x1FFF))" \
CL"(CODE(C:0x0000-C:0xFFFF))" \
CL"(CONST(C:0x0000-C:0xFFFF))"

AS_RUN= -$(AS) "$<" $(ASFLAGS)
CC_RUN= -$(CC) "$<" $(CCFLAGS)

AR_RUN= -$(AR) TRANSFER \
$(addsuffix $(COMMA),$(wordlist 2,$(words $(OBJECTS)),$(OBJECTS))) \
$(firstword $(OBJECTS)) \
TO $(DIRT_PREFIX)/$(NAME).$(SLX)

SLFILES= $(addsuffix .$(SLX),$(subst :,/,$(SLLIST)))

LD_RUN= -$(LD) \
$(call inject-comma,$(OBJECTS) $(SLFILES)) \
TO $(DIRT_PREFIX)/$(NAME).$(APX) \
$(LDFLAGS)

OH_RUN= -$(OH) $(DIRT_PREFIX)/$(NAME).$(APX) HEXFILE"($(DIRT_PREFIX)/$(NAME).$(OHX))"
