#!/bin/bash
#
# Author: Mario Stefanutti
# History:
# - 02/Feb/2017: First version
#
cd $PRJ_HOME/unix-utils/scripts
source set-proxy.sh
sudo cp docker-http-proxy.conf.set-no-proxy /etc/systemd/system/docker.service.d/http-proxy.conf
docker-restart.sh
cd -
