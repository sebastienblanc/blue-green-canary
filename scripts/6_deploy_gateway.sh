#!/bin/bash

kubectl apply -f src/main/istio/Gateway_VS_Openshift.yml
kubectl apply -f src/main/istio/Destination_rule_blue_green.yml