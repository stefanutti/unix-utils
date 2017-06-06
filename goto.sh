#!/bin/bash

#
# Usage: alias goto=". /path to .../goto.sh"
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

GOTO_HOME_DIRS="/home/stefanutti/prj"

DIRS=`find -L $GOTO_HOME_DIRS -maxdepth 2 -type d | grep -v "\-[0-9]\.[0-9]" | sort | grep -i "$1"`
NUM_DIRS=`find -L $GOTO_HOME_DIRS -maxdepth 2 -type d | grep -v "\-[0-9]\.[0-9]" | sort | grep -i "$1" | wc -l`

if [ $NUM_DIRS == 0 ]; then
    echo "nothing found"
elif [ $NUM_DIRS == 1 ]; then
    LINE="0"
    changeDir
else
    showDirs
    echo "Which number?"
    read LINE
    changeDir
fi

