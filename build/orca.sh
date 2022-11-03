#!/bin/bash -x

git clone git@github.com:harukats/jma-receipt-docker $HOME/wk/oss/jma-receipt
cd $HOME/wk/oss/jma-receipt
docker-compose up
