#!/bin/bash

kubectl -n one delete pods --field-selector=status.phase=Succeeded 
kubectl -n one delete pods --field-selector=status.phase=Failed