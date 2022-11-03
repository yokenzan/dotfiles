#!/bin/bash

echo ========== Initializing Node.js.. ==========

sudo apt install -y nodejs npm
sudo npm install n -g
sudo n stable
sudo apt purge -y nodejs npm

sudo npm install -g intelephense

echo ========== Completed Initializing Node.js ==========
