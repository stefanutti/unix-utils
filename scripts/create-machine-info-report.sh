#!/bin/bash
#
# Author: I@N
# History:
# - 02/Feb/2017: First version
#
FILENAME="${HOSTNAME}_$(date +'%d-%m-%Y_%H-%M-%S').txt"

DECORATION_STR="*** --- ***"

command_list=(
               "top -n10 -b" "ps aux" "vmstat" "sar" "ulimit" "ulimit -Hn" "ulimit -Sn" "ps -ef | grep java" "jps -lv" "sysctl -a"
               "cat /proc/sys/kernel/shmmax" "cat /proc/sys/kernel/shmmni" "cat /proc/sys/kernel/shmall"
               "ipcs -la" "cat /proc/sys/fs/file-max" "df -k" "ip a"
             )

for command in "${command_list[@]}"
do
   printf "${DECORATION_STR} Execution of $command ${DECORATION_STR}\n\n" >> $(echo ${FILENAME}) 2>&1
   eval "$command" >> $(echo ${FILENAME}) 2>&1
   printf "\n\n" >> $(echo ${FILENAME}) 2>&1
done

