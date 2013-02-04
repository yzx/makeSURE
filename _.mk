-include trunk/build/env.mk

# Places to go to build kept in SVN
SVN_BUILD_DIRS= \
trunk/Mark_4/barcode \
trunk/Mark_4/QVTrackerDaemon \
#

# Barcode SVN repositories
SVN_BARCODE_DIRS= \
trunk/Mark_4/barcode \
ThirdParty/openmax-1.0.2 \
ThirdParty/OpenMaxLib-r1p0-00bet0 \
#

# QVTracker SVN repositories
SVN_QVTRACKER_DIRS= \
trunk/Mark_4/QVTrackerDaemon \
ThirdParty/boost_1_49_0 \
ThirdParty/OpenNI-1.5.4 \
ThirdParty/IDS-UEYE-3.9 \
ThirdParty/i2c-tools-3.1.0 \
ThirdParty/lpng1511 \
ThirdParty/zlib-1.2.7 \
#

# SVN repository
SVN_URL=  http://svn.proiamsource.com/QubeVu
SVN_USER?=
SVN_PWD?=
SVN_DIRS= \
trunk/build \
$(SVN_BARCODE_DIRS) \
$(SVN_QVTRACKER_DIRS) \
#

ifeq ($(MAKECMDGOALS),help)
    SVN_USER=_
    SVN_PWD=_
endif

ifeq ($(MAKECMDGOALS),build)
    SVN_USER=_
    SVN_PWD=_
endif

SVN_USER := $(shell if [ -z $(SVN_USER) ] ; then read -p "Your SVN username : " REPLY ; echo $$REPLY ; fi )
SVN_PWD  := $(shell if [ -z $(SVN_PWD) ]  ; then read -p "Your SVN password : " REPLY ; echo $$REPLY ; fi )

ifeq ($(HOST_PLAT),)
    HOST_NAME= UNKNOWN
else
    HOST_NAME= $(HOST_PLAT)
endif

ifeq ($(HOST_PLAT),)
    ${warning Build system SEEDING operation or $(HOST_NAME) host platform}
endif

#all:
all: svn build
	@echo
	@echo "Done"

svn:
	@echo
	@echo "SVN acquisition for QubeVu ... "
	@$(foreach dir, $(SVN_DIRS), svn co --username $(SVN_USER) --password $(SVN_PWD) $(SVN_URL)/$(dir) $(dir);)

build:
	@echo
	@$(foreach dir, $(SVN_BUILD_DIRS) $(GIT_BUILD_DIRS), $(MAKE) -C $(dir) -f _.mk BUILD=$(BUILD) CONFIG=$(CONFIG) BMODE=$(BMODE) clean all;)

help:
	@echo
	@echo "This is global, top level build ... "
	@echo

-include debug.mk

