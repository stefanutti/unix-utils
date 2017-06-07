#!/bin/csh -f
#
# DESCRIPTION: Verify the RIL snapshoot
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
set control_file = "$1"
set counter = 0

#
# Check parameter and print usage or notes
#
if ("$control_file" == "") then
   echo "$0 error: invalid parameters"
   echo ""
   echo "Usage:"
   echo "$0 <control file> <directory containg files to check>"
   exit
endif

#
# Read the list of filenames and che cksum information
#
set checksums = `cat $control_file | awk '{print $1}'`
set filenames = `cat $control_file | awk '{print $3}'`

#
# For each file in the control list
#
foreach filename ($filenames)
   set counter = `expr $counter + 1`

   #
   # Check if the file exist
   #
   if (-e $filename) then

      #
      # And check if it has the same cksum
      #
      if (`cksum $filename | awk '{print $1}'` == $checksums[$counter]) then
         echo "     OK $filename"
      else
         echo "    NOK $filename. Source and destination are different"
      endif
   else
      echo "MISSING $filename"
   endif
end

