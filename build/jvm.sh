#!/bin/bash -x

curl -s "https://get.sdkman.io" | bash
source ~/.bash_profile
sdk install kotlin
sdk install gradle
sdk install java 19-tem
