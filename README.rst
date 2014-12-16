
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

To install, execute these instructions on a Rocks frontend: ::

    # rocks add roll *.iso
    # rocks enable roll intel
    # cd /export/rocks/install
    # rocks create distro
    # rocks run roll intel > add-roll.sh
    # bash add-roll.sh 2>&1 | tee  add-roll.out

In addition to the software itself, the roll installs intel environment
module files in: ::

    /opt/modulefiles/compilers/intel
    /opt/modulefiles/applications/mkl


Testing
----------

The intel-roll includes a test script which can be run to verify proper
installation of the intel-roll documentation, binaries and module files. To
run the test scripts execute the following command(s): ::

    # /root/rolltests/intel.t 
