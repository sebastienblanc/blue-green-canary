#!/bin/bash

tkn pipeline start bgc-build-deploy \
 --param="appName=canary"  \
 --param="color=#f2f25e"  \
 --param="message=Hola"  \
 --resource="appSource=bgc-git-source" \
 --resource="appImage=bgc-image" \
 --showlog
