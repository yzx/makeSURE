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

ifeq ($(CONFIG),Debug)
AS_BD_FLAG= DB
CC_BD_FLAG= OT"(2, Size)"
else
AS_BD_FLAG= DF"(NDEBUG)"
CC_BD_FLAG= OT"(8, Size)" DF"(NDEBUG)"
endif

SLFILES=  $(addprefix $(IDIR),$(addsuffix .$(SLX),$(SLFILE)))

ifneq ($(IDIR),)
INCDIR= INCDIR"($(subst $(space),$(SPACE), $(call inject-comma,$(IDIR))))"
endif

TCFLAGS= PR"($(DIRT)/"$*".$(LSX))" $(INCDIR) OJ"("$@")"

ASFLAGS= NOCO MACRO CASE EP $(AS_DB_FLAG) $(TCFLAGS)

CCFLAGS= NOIV LARGE MODDP2 OMF2 CD DB NOIP VB"(1)" $(CC_DB_FLAG) $(TCFLAGS)

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
