# unix-utils

This repository contains genaral Unix utilities + Docker utilities.

| Scripts                     | Description                                                    |
| :---                        | :---                                                           |
| set-environment.sh          | Script to set the environment                                  |
| set-environment.sh.template | Configuration template file (see wizard inside the script dir) |

## Info to set docker

I'm using an Ubuntu 16.04 LTM (64bit) to host Docker.

Note:
- if you have Windows consider to use VirtualBox with a VMI Ubuntu image (http://www.osboxes.org)

To install Docker follow the instructions here: https://store.docker.com/editions/community/docker-ce-server-ubuntu
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

Personal addons (this repo)
- git clone https://github.com/stefanutti/unix-utils.git

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
  - Or from the cloned stefanutti/unix-utils repo (this repo) run:
      - cd ./unix-utils
      - cp set-environment.sh.template set-environment.sh
        - Note: .template files have to be customized
          - If the environmente has been previously set you can use wizard to change the environment
            - wizard set-environment.sh.template (it will automatically generate the set-environment.sh file)
      - Note: Edit the set-environment.sh and customize the placeholders
        - export PRJ_HOME="#{Insert root directory for your projects:Not available. To be specified manually}"
        - export PRJ_HOME="$HOME/prj"
      - source ./set-environment.sh
      - . docker-set-proxy.sh (after having customized it for your needs - See note about .template files)
      - . docker-set-no-proxy.sh (to disable the proxy for a direct connection)

