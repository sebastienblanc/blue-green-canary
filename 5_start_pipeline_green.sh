#!/bin/bash

tkn pipeline start bgc-build-deploy \
 --param="appName=green"  \
 --param="color=#5bbf45"  \
 --param="message=Bonjour"  \
 --resource="appSource=bgc-git-source" \
 --resource="appImage=bgc-image" \
 --showlog
