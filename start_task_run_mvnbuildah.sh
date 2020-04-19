#!/bin/bash

tkn task start -n one mvn-buildah \
 --param="mavenMirrorUrl=http://nexus.rhd-workshop-infra:8081/nexus/content/groups/public"  \
 --param="dockerFile=src/main/docker/Dockerfile.jvm" \
 --inputresource="source=bgc-git-source" \
 --outputresource="builtImage=bgc-image-blue"  \
 --showlog
