#!/bin/bash
#
# Author: Mario Stefanutti
# History:
# - 02/Feb/2017: First version
# - 11/Nov/2017: If first parameter is "." search sub dirs into the current directory
# - 11/Nov/2017: Fix if input give is null
#
#
# Usage: alias goto=". /path-to-the-script-dir/goto.sh"
# Note: Change the GOTO_HOME_DIRS variable
#

showDirs() {
    x=0
    for D in $DIRS; do
        echo "$x $D" 
        ((x=x+1)) 
    done
}

changeDir() {
    x=0
    for D in $DIRS; do
        if [ $LINE = $x ]; then
            cd $D
            pwd 
        fi  
        ((x=x+1)) 
    done
}

GOTO_HOME_DIRS="$PRJ_HOME"

if [ $1 == "." ]; then
   DIRS=`find . -maxdepth 3 -type d | grep -v "\-[0-9]\.[0-9]" | grep -v "\/\." | sort | grep -i "$2"`
   NUM_DIRS=`find . -maxdepth 3 -type d | grep -v "\-[0-9]\.[0-9]" | grep -v "\/\." | sort | grep -i "$2" | wc -l`
else
   DIRS=`find -L $GOTO_HOME_DIRS -maxdepth 3 -type d | grep -v "\-[0-9]\.[0-9]" | grep -v "\/\." | sort | grep -i "$1"`
   NUM_DIRS=`find -L $GOTO_HOME_DIRS -maxdepth 3 -type d | grep -v "\-[0-9]\.[0-9]" | grep -v "\/\." | sort | grep -i "$1" | wc -l`
fi

if [ $NUM_DIRS == 0 ]; then
    echo "nothing found"
elif [ $NUM_DIRS == 1 ]; then
    LINE="0"
    changeDir
else
    showDirs
    echo "Which number?"
    read LINE
    if [ "$LINE" != "" ]; then
       changeDir
    fi
fi

