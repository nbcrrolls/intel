VERSION.MK.MASTER  = $(REDHAT.ROOT)/src/version.mk
VERSION.MK.INCLUDE = master.version.mk
include $(VERSION.MK.INCLUDE)

PACKAGE     = intel
CATEGORY    = compilers

NAME        = $(PACKAGE)-modules
RELEASE     = 0
VERSION     = $(INTEL_YEAR).$(INTEL_MAJOR).$(INTEL_MINOR)
PKGROOT     = /opt/modulefiles/$(CATEGORY)/$(PACKAGE)

RPM.EXTRAS  = AutoReq:No
