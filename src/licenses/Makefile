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
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)
	$(INSTALL) -m 644 license.txt $(ROOT)/$(PKGROOT)/
	$(INSTALL) -m 644 license-readme $(ROOT)/$(PKGROOT)/

clean::
	rm -rf $(NAME).spec.in
	rm -rf $(VERSION.MK.INCLUDE)

