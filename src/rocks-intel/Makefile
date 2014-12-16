#

REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk

pretar:: $(VERSION.MK.INCLUDE)

$(VERSION.MK.INCLUDE): 
	if [ -f $(VERSION.MK.MASTER) ]; then \
		/bin/cp $(VERSION.MK.MASTER) $@; \
	fi

build: 

install::
	mkdir -p $(ROOT)/$(PKGROOT)
	$(INSTALL) -m 755 addModPath  $(ROOT)/$(PKGROOT)/

clean::
	rm -rf $(VERSION.MK.INCLUDE)

