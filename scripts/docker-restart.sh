#!/bin/bash
#
# Author: Mario Stefanutti
# History:
# - 02/Feb/2017: First version
#
sudo systemctl daemon-reload
sudo systemctl show --property Environment docker
sudo systemctl restart docker

