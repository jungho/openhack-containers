#!/usr/bin/env bash
#create the namespace first
namespace=jungho-web

kubectl create --namespace="$namespace" -f configMap.yaml
kubectl create --namespace="$namespace" -f deployment.yaml
kubectl create --namespace="$namespace" -f service.yaml