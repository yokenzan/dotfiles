#!/bin/bash

: ========== Installing MySQL8.. ==========

# export DEBIAN_FRONTEND="noninteractive"

: remove MySQL5.7

sudo apt remove -y mysql-*

: install MySQL5.7

wget --user-agent="Mozilla" -O mysql-apt-config_0.8.14-1_all.deb https://dev.mysql.com/get/mysql-apt-config_0.8.14-1_all.deb

# interactive shell config

sudo dpkg -i ./mysql-apt-config_0.8.14-1_all.deb
sudo apt update
sudo apt install -y mysql-server mysql-client

: ========== Completed Installing MySQL8 ==========
