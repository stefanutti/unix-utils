. set-proxy.sh
sudo cp docker-http-proxy.conf.set-proxy /etc/systemd/system/docker.service.d/http-proxy.conf
./docker-restart.sh
