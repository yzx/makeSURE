include $(BUILD_BASE)/$(TOOL)/def.mk

CPU?= $(HPLAT)
CONFIG?= Debug
SDIR+= $(PRJ_BASE)

DIRT_TOP?= _
DIRT_PREFIX= $(DIRT_TOP)/$(CPU)/$(CONFIG)
DIRT= $(PRJ_BASE)/$(DIRT_PREFIX)/dirt

YNAME= $(DIRT_PREFIX)/$(NAME)

vpath %.xml   $(SDIR)
vpath %.$(SX) $(SDIR)
vpath %.$(AX) $(SDIR)
vpath %.c     $(SDIR)
vpath %.cpp   $(SDIR)

XMLFILES= $(addsuffix .xml,$(XMLFILE)) $(wildcard *.xml)
SFILES=   $(addsuffix .$(SX),$(SFILE)) $(wildcard *.$(SX))
AFILES=   $(addsuffix .$(AX),$(AFILE))  $(wildcard *.$(AX))
CFILES=   $(addsuffix .c,$(CFILE)) $(wildcard *.c)
CPPFILES= $(addsuffix .cpp,$(CPPFILE)) $(wildcard *.cpp)

OBJECT+= $(SFILES:.$(SX)=.$(OX))
OBJECT+= $(AFILES:.$(AX)=.$(OX))
OBJECT+= $(CFILES:.c=.$(OX))
OBJECT+= $(CPPFILES:.cpp=.$(OX))

OBJECTS= $(addprefix $(DIRT)/,$(OBJECT))

ifneq ($(BMODE),)
    VS_BMODE= //t:$(BMODE) 
    CB_BMODE= --$(BMODE) 
endif

