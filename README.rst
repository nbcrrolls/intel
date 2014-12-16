
.. hightlight:: rest

intel  Roll
==================

.. contents::

Introduction
---------------
This roll isntalls Intel Composer XE suite 
which includes c, c++ and fortran compilers, math kernel libraries,  
threading building blocks, integrated performance primitives.

This roll is build based on Triton Intell roll. 

The actual compilers and licenses are bought from Intel resellers. 
This roll only wraps the compilers into a Rocks roll for
installation into a Rocks cluster.

For more information about the Intel Compilers please visit the official web
page <a href="http://software.intel.com/en-us/intel-composer-xe"
target="_blank">Intel Composer XE Suites</a> 

Requirements
-------------

Install sdsc-roll (from SDSC/sdsc-roll repo). This roll provides needed DEVEL environment and
adjusts MODULEPATH needed to run applications (sdsc-etc-profile rpm).

To build/install this roll you must download intel compielrs soruce files (tgz)
in src/intel-compiler and src/intel-redist/. The files names match patterns
in ``*.version.mk.in`` files.

Building
-------------

To build the roll, execute : ::

    # make 2>&1 | tee build.log

A successful build will create the file ``intel-*.disk*.iso``.

Installing
------------

The roll installs on logn and compte nmodes when they are kickstarted during the cluster build.
On compute nodes only redist packages (libs) are installed.  The compilers will be available on login node.
To add  this roll to existing cluster, execute these instructions on a Rocks frontend node: ::

    # rocks add roll *.iso
    # rocks enable roll intel
    # cd /export/rocks/install
    # rocks create distro
    # rocks run roll intel > add-roll.sh

And on login node execute resulting add-roll.sh: ::

    # bash add-roll.sh 2>&1 | tee  add-roll.out

Reinstall compute nodes:  ::
    
    # rocks set host boot compute action=install
    # rocks run host compute reboot

In addition to the software itself, the roll installs intel environment
module files in: ::

    /opt/modulefiles/compilers/intel
    /opt/modulefiles/applications/mkl

If a clsuter has no login node, to intall compilers on the frontend execute the following 
command before running ``rocks add roll``: ::
    
    # /opt/rocks/bin/rocks add host attr localhost intelxe true

Testing
----------

The intel-roll includes a test script which can be run to verify proper
installation of the intel-roll documentation, binaries and module files. To
run the test scripts execute the following command(s): ::

    # /root/rolltests/intel.t 
