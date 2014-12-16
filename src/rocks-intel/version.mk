VERSION.MK.MASTER  = $(REDHAT.ROOT)/src/version.mk
VERSION.MK.INCLUDE = master.version.mk
include $(VERSION.MK.INCLUDE)

NAME        = rocks-intel
RELEASE     = 0
VERSION     = $(INTEL_YEAR).$(INTEL_MAJOR).$(INTEL_MINOR)
PKGROOT     = /opt/intel/rocks/bin

