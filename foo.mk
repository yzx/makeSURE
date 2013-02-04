EMPTY=
SPACE=$(EMPTY) $(EMPTY)
space=$(EMPTY)*$(EMPTY)
COMMA=$(EMPTY),$(EMPTY)
TAB=  $(EMPTY)	$(EMPTY)

define inject-comma
$(addsuffix $(COMMA),$(wordlist 2,$(words $(1)),$(1))) $(firstword $(1))
endef

