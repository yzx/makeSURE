OBJECT+= $(CFILES:.c=.o)
OBJECT+= $(CPPFILES:.cpp=.o)
HOBJECTS= $(addprefix hdirt/,$(OBJECT))
TOBJECTS= $(addprefix tdirt/,$(OBJECT))

vpath %.c   $(SDIR)
vpath %.cpp $(SDIR)
CFILES=   $(addsuffix   .c,$(CFILE))
CPPFILES= $(addsuffix .cpp,$(CPPFILE))
IDIRS=    $(addprefix   -I,$(IDIR)) $(addprefix -I,$(SDIR))
CCDEFS=   $(addprefix   -D,$(CCDEF))
HCDEFS=   $(addprefix   -D,$(HCDEF))
TCDEFS=   $(addprefix   -D,$(TCDEF))
CCFLAGS=  $(addprefix    -,$(CCFLAG))
_FLAGS=   -c -Wall -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)"

LDIRS=    $(addprefix   -L,$(LDIR))
LCNAMES=  $(addprefix   -l,$(LCNAME))
LHNAMES=  $(addprefix -lh-,$(LPNAME))
LTNAMES=  $(addprefix -lt-,$(LPNAME))
LFLAGS=   $(addprefix    -,$(LFLAG))

ifneq ($(BMODE),)
    VS_BMODE= //t:$(BMODE) 
    CB_BMODE= --$(BMODE) 
endif

