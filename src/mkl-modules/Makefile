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
	echo $(VERSION)
	echo $(INTELVERS)

install::
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)
	for V in $(VERSION) $(EXTRA_MODULE_VERSIONS); do \
	  cp *.module $(ROOT)/$(PKGROOT)/$$V; \
	  cp *.version $(ROOT)/$(PKGROOT)/.version.$$V; \
	  perl -pi -e 's#COMPILERNAME#$(COMPILERNAME)#g;' \
		   -e 's#MPINAME#$(ROLLCOMPILER)#g;' \
		   -e 's#ROLLCOMPILER#$(ROLLCOMPILER)#g;' \
		   -e 's#ROLLMPI#$(ROLLMPI)#g;' \
		   -e 's#ROLLOPTS#$(ROLLOPTS)#g;' \
		   -e 's#ROLLPY#$(ROLLPY)#g;' \
		   -e "s#VERSION#$$V#g;" \
		   -e 's#INTELVERS#$(INTELVERS)#g;' \
	    $(ROOT)/$(PKGROOT)/.version.$$V $(ROOT)/$(PKGROOT)/$$V; \
	done
	ln -s $(PKGROOT)/.version.$(VERSION) $(ROOT)/$(PKGROOT)/.version

clean::
	rm -rf $(VERSION.MK.INCLUDE)

