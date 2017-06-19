#!/bin/csh -f
#
# DESCRIPTION: Make the RIL snapshoot
#
# AUTHOR: Mario Stefanutti
#
# REVISION HISTORY:
# - 28/Mag/2009 - Creation date
#
################################################################################
#
# Variables declaration
#
set directory = "$1"

#
# Check parameter and print usage or notes
#
if ("$directory" == "") then
   echo "$0 error: invalid parameters"
   echo ""
   echo "Usage:"
   echo "$0 <directory containg files to check>"
   exit
endif

#
# Generate control info (cksum)
#
find $directory -type f -exec cksum {} \;
