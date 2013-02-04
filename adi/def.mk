AS=      easmBLKFN
CC=      ccblkfn
AR=      ccblkfn
LD=      ccblkfn
LN=      linker
EL=      elfloader

SX=      s
OX=      doj
SLX=     dlb
LDX=     dxe

CONFIG_CC_FLAGS= -O -Ov100
CONFIG_LD_FLAGS= -flags-link -ip -flags-link -MDRELEASE -flags-link -e
ifneq ($(CONFIG),Release)
CONFIG_DEF?= _DEBUG
CONFIG_CC_FLAGS= -g
CONFIG_LD_FLAGS= -flags-link -MDDEBUG -add-debug-libpaths
endif

CCDEFS=  $(addprefix -D,$(CCDEF) $(CONFIG_DEF))
IDIRS=   $(addprefix -I,$(IDIR) $(SDIR))

TTFLAGS= -proc ADSP-$(CPU) -si-revision 0.4
TCFLAGS= $(TTFLAGS) $(CONFIG_CC_FLAGS) -gnu-style-dependencies
TYFLAGS= -flags-link -od,.\.

ASFLAGS= $(TCFLAGS)

CCFLAGS= -c -cplbs -structs-do-not-overlap \
-no-multiline -double-size-32 -decls-strong -warn-protos $(TCFLAGS) $(IDIRS)

LIB_PREFIX= lib
ARFLAGS= -build-lib $(TCFLAGS)

LDIRS=   $(addprefix -L,$(foreach ITEM,$(SLLIST),$(word 1,$(subst :, ,$(ITEM)))))
SLFILES= $(addprefix -l,$(foreach ITEM,$(SLLIST),$(word 2,$(subst :, ,$(ITEM)))))
#LDFILE= -TC:/@/_/bii/svn-dev/trunk/FW/target/CrossCore/TestBench/system/startup_ldf/app.ldf
LDFLAGS= $(TTFLAGS) $(LDFILE) -no-mem $(LDIRS) $(CONFIG_LD_FLAGS) $(TYFLAGS) 

AS_RUN= $(AS) $(ASFLAGS) -o "$@" "$<"
CC_RUN= $(CC) $(CCFLAGS) -o "$@" "$<"
AR_RUN= $(AR) $(ARFLAGS) -o $(DIRT_PREFIX)/$(LIB_PREFIX)$(NAME).$(SLX) $(OBJECTS) $(TYFLAGS)
LD_RUN= $(LD) $(LDFLAGS) -o $(YNAME).$(LDX) $(OBJECTS) $(SLFILES)

