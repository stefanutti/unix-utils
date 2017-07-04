. set-no-proxy.sh
sudo cp docker-http-proxy.conf.set-no-proxy /etc/systemd/system/docker.service.d/http-proxy.conf
./docker-restart.sh
