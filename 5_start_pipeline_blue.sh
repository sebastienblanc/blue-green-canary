#!/bin/bash

tkn pipeline start bgc-build-deploy \
 --param="mavenMirrorUrl=http://nexus.rhd-workshop-infra:8081/nexus/content/groups/public"  \
 --param="appName=blue"  \
 --param="color='#6bbded'"  \
 --param="message=Hello"  \
 --resource="appSource=bgc-git-source" \
 --resource="appImage=bgc-image" \
 --showlog
