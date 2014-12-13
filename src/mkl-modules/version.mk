VERSION.MK.MASTER = $(REDHAT.ROOT)/src/version.mk
VERSION.MK.INCLUDE = master.version.mk
include $(VERSION.MK.INCLUDE)

PACKAGE     = mkl
CATEGORY    = applications

NAME        = $(PACKAGE)-modules
RELEASE     = 0
VERSION     = $(L_MKL_VERSION)
INTELVERS   = $(INTEL_YEAR).$(INTEL_MAJOR).$(INTEL_MINOR)

PKGROOT     = /opt/modulefiles/$(CATEGORY)/$(PACKAGE)

RPM.EXTRAS  = AutoReq:No
