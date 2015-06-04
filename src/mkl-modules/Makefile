#

REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(NBCRDEVEL)/NBCR.mk

pretar:: $(VERSION.MK.INCLUDE)

$(VERSION.MK.INCLUDE): 
	if [ -f $(VERSION.MK.MASTER) ]; then \
		/bin/cp $(VERSION.MK.MASTER) $@; \
	fi

build:

install:: modulefile-install
	sed -i 's/INTELVERS/$(INTELVERS)/g' $(ROOT)/$(PKGROOT)/$(VERSION)

clean::
	rm -rf $(VERSION.MK.INCLUDE)

