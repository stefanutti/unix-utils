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

GOTO_HOME_DIRS="$PRJ_HOME"

DIRS=`find -L $GOTO_HOME_DIRS -maxdepth 3 -type d | grep -v "\-[0-9]\.[0-9]" | grep -v "\/\." | sort | grep -i "$1"`
NUM_DIRS=`find -L $GOTO_HOME_DIRS -maxdepth 3 -type d | grep -v "\-[0-9]\.[0-9]" | grep -v "\/\." | sort | grep -i "$1" | wc -l`

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

