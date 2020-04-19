#!/bin/bash

docker login quay.io

docker tag $1 quay.io/rhdevelopers/blue-green-canary

docker push quay.io/rhdevelopers/blue-green-canary
