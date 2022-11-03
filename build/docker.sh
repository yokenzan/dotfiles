#!/bin/bash -x

echo install and setup docker
echo - https://blog.jp.square-enix.com/iteng-blog/posts/00024-wsl2-docker-ce/
echo - https://dev.to/felipecrs/simply-run-docker-on-wsl2-3o8
echo - https://qiita.com/kuwa_tw/items/cfba33d0678b621808a8


echo ========== Installing Docker.. ==========

echo https://docs.docker.com/engine/install/ubuntu/

sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo apt install -y ca-certificates curl gnupg lsb-release
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin


echo https://github.com/microsoft/WSL/discussions/4872?sort=top

sudo update-alternatives --set iptables  /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy


echo https://docs.docker.com/engine/install/linux-postinstall/

sudo groupadd docker
sudo usermod -aG docker $USER


echo https://qiita.com/rasuk/items/a36b29b8c79d02fc551a

sed $HOME/.docker/config.json -i.bk -e 's/credsStore/credStore/'


echo ========== Completed Installing Docker ==========
