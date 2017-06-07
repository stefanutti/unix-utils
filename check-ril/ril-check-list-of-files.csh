#!/bin/csh -f
#
# DESCRIPTION: Verify the RIL snapshoot
#
# AUTHOR: Mario Stefanutti
#
# REVISION HISTORY:
# - 18/Ago/2014 - Creation date
#
################################################################################
#
# Variables declaration
#
set control_file = "$1"

#
# Check parameter and print usage or notes
#
if ("$control_file" == "") then
   echo "$0 error: invalid parameters"
   echo ""
   echo "Usage:"
   echo "$0 <control file - produced by ls with no path>"
   exit
endif

#
# Read the list of filenames (plain). Works also with relative path names
#
set filenames = `cat $control_file`

#
# For each file in the control list
#
foreach filename ($filenames)

   #
   # Check if the file exist
   #
   if (-e $filename) then
      echo "     OK $filename"
   else
      echo "MISSING $filename"
   endif
end

