HPLAT_NAME= \
linux \
darwin \
msys \
#

HPLAT= $(word 1, $(filter $(HPLAT_NAME), $(shell uname -a | tr [A-Z] [a-z])))

HPLAT_VAR?=
TPLAT_VAR?=

ifeq ($(HPLAT),linux)
    HPLAT_FIX?=    x
    HTOOL_PREFIX?=
    TTOOL_PREFIX?= arm-linux-gnueabi-
    
endif

ifeq ($(HOST_PLAT), darwin)
    HPLAT_FIX?=    m
    HTOOL_PREFIX?=
    TTOOL_PREFIX?= _
endif

ifeq ($(HOST_PLAT), msys)
    HPLAT_FIX?=    w
    HTOOL_PREFIX?= mingw32-
    TTOOL_PREFIX?= arm-none-linux-gnueabi-
endif
