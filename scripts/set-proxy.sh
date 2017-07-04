#!/bin/bash
#
# Author: Mario Stefanutti
# History:
# - 02/Feb/2017: First version
#
export HTTP_PROXY=172.26.0.133:3128
export HTTPS_PROXY=172.26.0.133:3128
export FTP_PROXY=172.26.0.133:3128
export ALL_PROXY=socks://172.26.0.133:3128
export SOCKS_PROXY=socks://172.26.0.133:3128
export NO_PROXY=localhost,127.0.0.0/8,docker-registry.somecorporation.com

export http_proxy=172.26.0.133:3128
export https_proxy=172.26.0.133:3128
export ftp_proxy=172.26.0.133:3128
export all_proxy=socks://172.26.0.133:3128
export socks_proxy=socks://172.26.0.133:3128
export no_proxy=localhost,127.0.0.0/8,docker-registry.somecorporation.com
