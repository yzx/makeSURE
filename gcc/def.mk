ifneq ($(CROSS),)
-include $(BUILD_BASE)/$(TOOL)/$(CROSS)/def.mk
endif

CC=      $(addprefix $(TOOL_PREFIX), gcc)
AR=      $(addprefix $(TOOL_PREFIX), ar)
LD=      $(addprefix $(TOOL_PREFIX), gcc)
LN=      $(addprefix $(TOOL_PREFIX), ld)
OBJDUMP=
OBJCOPY=
SIZE=
STRIP=
ELFL=

SX=      s
OX=      o
SLX=     a
SLX=     a
ifeq ($(HPLAT),msys)
LDX=     .exe
endif

CONFIG_CC_FLAGS= -g0
CONFIG_LD_FLAGS=
ifneq ($(CONFIG),Release)
CONFIG_DEF?= _DEBUG
CONFIG_CC_FLAGS= -g
CONFIG_LD_FLAGS=
endif

CCDEFS=  $(addprefix -D,$(CCDEF) $(CONFIG_DEF))
IDIRS=   $(addprefix -I ,$(IDIR) $(SDIR))

ASFLAGS=

#CC_FLAGS= -O0 -g3 -fmessage-length=0
CCFLAGS= -c -Wall -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" $(CONFIG_CC_FLAGS) $(IDIRS) $(CCDEFS)

LIB_PREFIX= lib
ARFLAGS= rcs

LDIRS=   $(addprefix -L,$(foreach ITEM,$(SLLIST),$(word 1,$(subst :, ,$(ITEM)))))
SLFILES= $(addprefix -l,$(foreach ITEM,$(SLLIST),$(word 2,$(subst :, ,$(ITEM)))))

#LD_FLAGS= -static
LDFLAGS= $(LDIRS)

#PLATFORM_LIBS += -L $(shell dirname `$(CC) $(CFLAGS) -print-libgcc-file-name`) -lgcc

AS_RUN= $(AS) $(ASFLAGS) -o "$@" "$<"
CC_RUN= $(CC) $(CCFLAGS) -o "$@" "$<"
AR_RUN= $(AR) $(ARFLAGS) $(DIRT_PREFIX)/$(LIB_PREFIX)$(NAME).$(SLX) $(OBJECTS)
LD_RUN= $(LD) $(LDFLAGS) -o $(YNAME)$(LDX) $(OBJECTS) $(SLFILES)

