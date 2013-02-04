include $(BUILD_BASE)/err.mk
include $(BUILD_BASE)/foo.mk

HPLAT_NAME= \
linux \
darwin \
msys \
$(OS) \
#

HPLAT= $(word 1, $(filter $(HPLAT_NAME), $(shell uname -a | tr [A-Z] [a-z])))

HPLAT_VAR?=
TPLAT_VAR?=

ifeq ($(HPLAT),linux)
    HPLAT_FIX?=    x
    
endif

ifeq ($(HPLAT), darwin)
    HPLAT_FIX?=    m
endif

ifeq ($(HPLAT), msys)
    HPLAT_FIX?=    w
endif

TOOL?= gcc
#CROSS?=

PROJ_BASE?= .
PRJ_BASE= $(subst $(SPACE),\ ,$(PROJ_BASE))

-include $(PRJ_BASE)/env.mk
-include $(BUILD_BASE)/$(TOOL)/env.mk

PATH:= $(TOOL_BASE):$(PATH)

