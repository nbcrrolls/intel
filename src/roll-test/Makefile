REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(NBCRDEVEL)/NBCR.mk

build:

install:: roll-test-install
	-mv $(ROOT)/$(PKGROOT)/*.t $(ROOT)/$(PKGROOT)/$(ROLLNAME).t

clean::
