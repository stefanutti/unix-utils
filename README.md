# unix-utils

This dir contains genaral Unix utilities + docker utilities:
- TBF

Since Docker runs inside Unix and I have a Windows 8.1 (64bit) machine, I'm using an Ubuntu 16.04 LTM (64bit) virtual machine on VirtualBox 5.1 to host Docker.

For the download of the VMI Ubuntu image I used this site: http://www.osboxes.org/

And then I inslalled Docker, following the instructions here: https://store.docker.com/editions/community/docker-ce-server-ubuntu
- sudo apt-get -y install apt-transport-https ca-certificates curl
- curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
- sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
- sudo apt-get update
- sudo apt-get -y install docker-ce
- sudo docker run hello-world
- Additional configuration
  - sudo groupadd docker
  - sudo usermod -aG docker $USER
  - ^D logout + login
  - docker run hello-world (now without using sudo)

Necessary addons (if not installed)
- sudo apt-get -y install git

Personal addons
- git clone https://github.com/stefanutti/docker-utils.git

In case you are inside a protected network, remember to setup the proxy:
- Set the proxy in the Ubuntu settings (standard system proxy configuration)
- For Docker to work properly it is also necessary to:
  - export the proxy variables
    - export HTTP_PROXY=http://proxy.example.com:80/
    - export HTTPS_PROXY=http://proxy.example.com:80/
  - And then follows the instructions here: http://stackoverflow.com/questions/23111631/cannot-download-docker-images-behind-a-proxy:
    - mkdir /etc/systemd/system/docker.service.d
    - vi /etc/systemd/system/docker.service.d/http-proxy.conf
      - [Service]
      - Environment="HTTP_PROXY=http://proxy.example.com:80/"
    - sudo systemctl daemon-reload
    - sudo systemctl restart docker
  - Or from the cloned stefanutti/docker-utils directory (clone this repo) run:
      - set-proxy-xxx.sh (after having customized it for your needs)
      - set-no-proxy.sh (to disable the proxy for a direct connection)

