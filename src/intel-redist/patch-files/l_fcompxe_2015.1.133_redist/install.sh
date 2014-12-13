#!/bin/bash
# Copyright 1999-2014, Intel Corporation, All Rights Reserved
# This script installs the Intel(R) redist content

# The  source code,  information and material  ("Material")  contained herein is
# owned  by  Intel  Corporation or its suppliers or licensors, and title to such
# Material  remains  with  Intel  Corporation  or  its  suppliers  or licensors.
# The  Material  contains proprietary information of  Intel or its suppliers and
# licensors.   The Material is protected by  worldwide copyright laws and treaty
# provisions. No part of the Material may be used, copied, reproduced, modified,
# published,  uploaded, posted, transmitted, distributed or disclosed in any way
# without Intel's prior express written permission. No license under any patent,
# copyright  or other intellectual property rights in the Material is granted to
# or conferred upon you, either expressly,  by implication, inducement, estoppel
# or  otherwise.  Any license  under such intellectual  property rights  must be
# express and approved by Intel in writing.
# Unless otherwise agreed by Intel in writing, you may not  remove or alter this
# notice or any other notice embedded in Materials by Intel or Intel's suppliers
# or licensors in any way.

TOUCH_SPACE()
{
    local dir_to_check=$1
    local dir_end_path='hags7823782318#@123kjhknmnzxmnz'
    local err=0
    
    if [ -d "$dir_to_check" ] ; then
        if [ -w "$dir_to_check" ] ; then
            mkdir "$dir_to_check/$dir_end_path" &> /dev/null
	    err=$?
            if [ "$err" = "0" ] ; then
                rmdir "$dir_to_check/$dir_end_path" &> /dev/null
            fi
        else
            err=1
        fi
    else
        TOUCH_SPACE "`dirname $dir_to_check`" "$dir_end_path"
        err=$?
    fi
    return $err
}

CREATE_ENV_FILE_SH () {

DESTINATION_0="$INSTALL_PATH"
mkdir -p $DESTINATION_0/bin &>/dev/null
# need to reset because of rocks build 
DESTINATION="/opt/intel"

echo  "#!/bin/sh
# Copyright  (C) 1985-2014 Intel Corporation. All rights reserved.
#
# The information and source code contained herein is the exclusive property
# of Intel Corporation and may not be disclosed, examined, or reproduced in
# whole or in part without explicit written authorization from the Company.
#
# Invoke this script with the 'source' command. For example:
#
#    source <my_install_location>/bin/compilervars.sh [ ia32 | intel64 ]

if [ \"\$1\" != \"ia32\" -a \"\$1\" != \"intel64\" ]; then
  echo \"ERROR: Unknown switch \"\$1\". Accepted values: ia32, intel64\"
  case \$0 in
    *compilervars*)
        exit 1;
        ;;
  esac
  return 1;
fi

if [ -z \"\${PATH}\" ]
  then
      PATH=\"$DESTINATION/bin/\$1:$DESTINATION/mpirt/bin/\$1\"; export PATH
      if [ \"\${I_MPI_ROOT}\" ]
      then
         PATH=\"\$I_MPI_ROOT/\$1/bin:\${PATH}\"; export PATH
      fi
  else
     PATH=\"$DESTINATION/bin/\$1:$DESTINATION/mpirt/bin/\$1:\${PATH}\"; export PATH
     if [ \"\${I_MPI_ROOT}\" ]
     then
        PATH=\"\$I_MPI_ROOT/\$1/bin:\${PATH}\"; export PATH
     fi
fi

if [ -z \"\${LD_LIBRARY_PATH}\" ]
   then
      LD_LIBRARY_PATH=\"$DESTINATION/compiler/lib/\$1:$DESTINATION/mpirt/lib/\$1\"; export LD_LIBRARY_PATH
      if [ \"\${I_MPI_ROOT}\" ]
      then
          LD_LIBRARY_PATH=\"\$I_MPI_ROOT/\$1/lib:\${LD_LIBRARY_PATH}\"; export LD_LIBRARY_PATH
      fi
   else
      LD_LIBRARY_PATH=\"$DESTINATION/compiler/lib/\$1:$DESTINATION/mpirt/lib/\$1:\${LD_LIBRARY_PATH}\"; export LD_LIBRARY_PATH
      if [ \"\${I_MPI_ROOT}\" ]
      then
         LD_LIBRARY_PATH=\"\$I_MPI_ROOT/\$1/lib:\${LD_LIBRARY_PATH}\"; export LD_LIBRARY_PATH
      fi 
fi
if [ -z \"\${LIBRARY_PATH}\" ]
   then
       LIBRARY_PATH=\"$DESTINATION/compiler/lib/\$1\"; export LIBRARY_PATH
   else
       LIBRARY_PATH=\"$DESTINATION/compiler/lib/\$1:\${LIBRARY_PATH}\"; export LIBRARY_PATH
fi

if [ -z \"\${MIC_LD_LIBRARY_PATH}\" ]
   then
      MIC_LD_LIBRARY_PATH=\"$DESTINATION/compiler/lib/mic:/opt/intel/mic/coi/device-linux-release/lib:/opt/intel/mic/myo/lib\"; export MIC_LD_LIBRARY_PATH
   else
      MIC_LD_LIBRARY_PATH=\"$DESTINATION/compiler/lib/mic:/opt/intel/mic/coi/device-linux-release/lib:/opt/intel/mic/myo/lib:\${MIC_LD_LIBRARY_PATH}\"; export MIC_LD_LIBRARY_PATH
fi

if [ -z \"\${NLSPATH}\" ] 
   then
      NLSPATH=\"$DESTINATION/compiler/lib/\$1/locale/%l_%t/%N\"; export NLSPATH 
   else
      NLSPATH=\"$DESTINATION/compiler/lib/\$1/locale/%l_%t/%N:\${NLSPATH}\"; export NLSPATH
fi

" > $DESTINATION_0/bin/$ENV_SCRIPT_SH

chmod 755 $DESTINATION_0/bin/$ENV_SCRIPT_SH

}

CREATE_ENV_FILE_CSH () {

DESTINATION_0="$INSTALL_PATH"
mkdir -p $DESTINATION_0/bin &>/dev/null
# need to reset because of rocks build 
DESTINATION="/opt/intel"
echo  "#!/bin/csh
# Copyright  (C) 1985-2014 Intel Corporation. All rights reserved.
#
# The information and source code contained herein is the exclusive property
# of Intel Corporation and may not be disclosed, examined, or reproduced in
# whole or in part without explicit written authorization from the Company.
#
# Invoke this script with the 'source' command. For example:
#
#    source <my_install_location>/bin/compilervars.csh [ ia32 | intel64 ]

if ( \"\$1\" != \"ia32\" && \"\$1\" != \"intel64\" ) then
  echo \"ERROR: Unknown switch \"\$1\". Accepted values: ia32, intel64\"
  exit 1
endif

if !(\$?PATH) then
    setenv PATH $DESTINATION/bin/\${1}:$DESTINATION/mpirt/bin/\${1}
    if (\$?I_MPI_ROOT) then
      setenv PATH \$I_MPI_ROOT/\${1}/bin:\${PATH}
    endif
else
    setenv PATH $DESTINATION/bin/\${1}:$DESTINATION/mpirt/bin/\${1}:\${PATH}
    if (\$?I_MPI_ROOT) then
      setenv PATH \$I_MPI_ROOT/\${1}/bin:\${PATH}
    endif
endif

if !(\$?LD_LIBRARY_PATH) then
     setenv LD_LIBRARY_PATH $DESTINATION/compiler/lib/\${1}:$DESTINATION/mpirt/lib/\${1}
     if (\$?I_MPI_ROOT) then
       setenv LD_LIBRARY_PATH \$I_MPI_ROOT/\${1}/lib:\${LD_LIBRARY_PATH}
     endif
   else
     setenv LD_LIBRARY_PATH $DESTINATION/compiler/lib/\${1}:$DESTINATION/mpirt/lib/\${1}:\${LD_LIBRARY_PATH}
     if (\$?I_MPI_ROOT) then
       setenv LD_LIBRARY_PATH \$I_MPI_ROOT/\${1}/lib:\${LD_LIBRARY_PATH}
     endif
endif
if !(\$?LIBRARY_PATH) then
       setenv LIBRARY_PATH $DESTINATION/compiler/lib/\${1}
   else
       setenv LIBRARY_PATH $DESTINATION/compiler/lib/\${1}:\${LIBRARY_PATH}
endif

if !(\$?MIC_LD_LIBRARY_PATH) then
     setenv MIC_LD_LIBRARY_PATH $DESTINATION/compiler/lib/mic:/opt/intel/mic/coi/device-linux-release/lib:/opt/intel/mic/myo/lib
   else
     setenv MIC_LD_LIBRARY_PATH $DESTINATION/compiler/lib/mic:/opt/intel/mic/coi/device-linux-release/lib:/opt/intel/mic/myo/lib:\${MIC_LD_LIBRARY_PATH}
endif

if !(\$?NLSPATH) then
       setenv NLSPATH $DESTINATION/compiler/lib/\${1}/locale/%l_%t/%N
   else
       setenv NLSPATH $DESTINATION/compiler/lib/\${1}/locale/%l_%t/%N:\${NLSPATH}
endif

" > $DESTINATION_0/bin/$ENV_SCRIPT_CSH

chmod 755 $DESTINATION_0/bin/$ENV_SCRIPT_CSH

}

function print_help()
{
    echo "Usage: install.sh [--install-path <install location> | -i <install location> | --help]"
    echo "		-i <install location>"
    echo "		--install-path <install location>    to relocate package content"
    echo "		    -e or --eula                     to accept the terms and conditions of license agreement"
    echo "		                                     in silent (relocation) installtion mode"
    echo "		--help                               print this message and exit"
    echo ""
    echo "Copyright 2006-2014, Intel Corporation, All Rights Reserved."
}

# ---------------------------------------
#THIS_PACKAGEID=l_cprof_b_11.1.044
THIS_PACKAGEID="composer_xe_2015.1.133"
EULA="license.txt"
RELEASE_NUM=$(echo $THIS_PACKAGEID | cut -f3 -d ".")

INSTALL_PATH="$HOME"

PACKAGE="composer_xe_2015.1.133"

PROGRAM_DIR=$(dirname $0)
# REDIST_CONTENT="lib license.txt jp_license.txt .uninstall.sh"
REDIST_CONTENT="compiler mpirt license.txt .uninstall.sh credist fredist"
ENV_SCRIPT_SH="compilervars.sh"
ENV_SCRIPT_CSH="compilervars.csh"
THIS_PROGRAM=$(basename $0)
COMMAND_LINE=FALSE
pushd $PROGRAM_DIR > /dev/null
FILE_SRC_DIR=$(pwd)

echo "Purpose: Intel(R) Parallel Studio XE Update 1 Composer Edition for Fortran Linux* Redistribution Content"
echo "Package Version: $PACKAGE"
if [ "$1" != "" ]; then
    ARG1=$1
    ARG2=$2
    ARG3=$3
    if [ "$ARG1" == "--help" ] || [ "$ARG1" == "-h" ] ; then
        print_help
        exit 0
    fi
    ACCEPTED_EULA=
    if [ "$ARG1" == "--eula" ] || [ "$ARG1" == "-e" ] ; then
	ACCEPTED_EULA=TRUE
	if [ "$ARG2" == "--install-path" ] || [ "$ARG2" == "-i" ] ; then
    	    if [ "$ARG2" != "" ]; then
        	INSTALL_PATH="$ARG3"
        	COMMAND_LINE=TRUE  
	    else
    		print_help
    		exit 1
	    fi
	else
    	    print_help
    	    exit 1
	fi
    else
	if [ "$ARG1" == "--install-path" ] || [ "$ARG1" == "-i" ] ; then
    	    if [ "$ARG2" != "" ]; then
        	INSTALL_PATH="$ARG2"
        	COMMAND_LINE=TRUE  
	    else
    		print_help
    		exit 1
	    fi
	else
    	    print_help
    	    exit 1
	fi
	if [ "$ARG3" == "--eula" ] || [ "$ARG3" == "-e" ] ; then
	    ACCEPTED_EULA=TRUE
	fi
    fi
    if [ "$COMMAND_LINE" == "TRUE" ] && [ "$ACCEPTED_EULA" != "TRUE" ] ; then
	print_help
    	exit 1
    fi
fi
if [ "$COMMAND_LINE" != "TRUE" ]; then
    echo ""
    echo "--------------------------------------------------------------------------------"
    echo "Please carefully read the following license agreement.  Prior to installing the"
    echo "software you will be asked to agree to the terms and conditions of the following"
    echo "license agreement."
    echo "--------------------------------------------------------------------------------"
    echo -n "Press Enter to continue   :   "
    read CONTINUE &> /dev/null
    echo ; echo
    more "$EULA"
    echo
    ACCEPTED=FALSE
    while [ "$ACCEPTED" != "TRUE" ]
    do
        echo "Do you agree to be bound by the terms and conditions of this license agreement?"
        if [ "$VERBOSE_MODE" = "1" ]; then echo 'GET_ACCEPTANCE()'; fi
        echo -n "'accept' to continue, 'reject' to return to the main menu   :   "
        read ACCEPTANCE &> /dev/null
        # eliminate white space
        ACCEPTANCE="$(echo $ACCEPTANCE | sed -e'1,$s/ *$//g')"
        ACCEPTANCE="$(echo $ACCEPTANCE | sed -e'1,$s/[[:space:]]*$//g' )"
        echo
        if echo "$ACCEPTANCE" | grep -i '^reject$' &> /dev/null ; then
            echo "The contents of this package will not be installed."
            exit 0
        elif echo "$ACCEPTANCE" | grep -i '^accept$' &> /dev/null ; then
            ACCEPTED=TRUE
        else
            ACCEPTED=FALSE
        fi
    done
    
    PROPER_INSTALL_PATH=FALSE
    while [ "$PROPER_INSTALL_PATH" == "FALSE" ]
    do
        echo -n "Install location: [$INSTALL_PATH] "
        read INSTALL_CONFIRM
        INSTALL_CONFIRM="$(echo $INSTALL_CONFIRM | sed -e'1,$s/ *$//g')"
        INSTALL_CONFIRM="$(echo $INSTALL_CONFIRM | sed -e'1,$s/[[:space:]]*$//g' )"
        if [ "$INSTALL_CONFIRM" == "" ]; then
            INSTALL_CONFIRM=$INSTALL_PATH
        fi
        if [ $(echo "$INSTALL_CONFIRM" | grep ' ' 2>/dev/null | wc -l) == "0" ]; then
            PROPER_INSTALL_PATH="TRUE"
        else
            echo "Install path cannot contain whitespaces!"
            INSTALL_CONFIRM=""
        fi
    done

    if [ "$INSTALL_CONFIRM" != "" ]; then
        INSTALL_PATH="$INSTALL_CONFIRM"
    fi

    echo "This program will install the $PACKAGE software"
    echo "in this location: $INSTALL_PATH"
    echo ""
    echo "Previous contents will be overwritten."
    echo ""
    echo -n 'Continue with the installation?  (yes / no) [ default = yes ]: '
    read CONTINUE
    CONTINUE=$(echo $CONTINUE | tr [A-Z] [a-z])
    echo ""
    if [ "$CONTINUE" = "yes" ] || [ "$CONTINUE" = "y" ] || [ "$CONTINUE" = "" ]; then
        echo "Proceeding with installation program $THIS_PROGRAM ..."
    else
        echo "Aborting installation program."
        exit 1
    fi 
fi

TOUCH_SPACE $INSTALL_PATH
err=$?

if [ "x$err" != "x0" ] ; then
    echo "Cannot create directory $INSTALL_PATH due to insufficient permissions.  Exiting program."
    exit 1
fi

mkdir -p $INSTALL_PATH &>/dev/null
if [ ! -d $INSTALL_PATH ]; then
    echo "Cannot create directory $INSTALL_PATH.  Exiting program."
    exit 1
fi
pushd $INSTALL_PATH > /dev/null
for THIS_CONTENT in $REDIST_CONTENT
do
    [ -e "$FILE_SRC_DIR/$THIS_CONTENT" ] && cp -rp $FILE_SRC_DIR/$THIS_CONTENT .
done
mv ./.uninstall.sh uninstall.sh
chmod 755 uninstall.sh
popd > /dev/null
popd > /dev/null
CREATE_ENV_FILE_SH
CREATE_ENV_FILE_CSH
echo "Installation program $THIS_PROGRAM completed."
exit 0
