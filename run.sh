#!/bin/bash

# Installe repo prometheus-community pour récupérer la charte Prometheus et Kube-state-metrics
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Deploie le Kube state metrics
helm install ksm-rel prometheus-community/kube-state-metrics --create-namespace -n ksm-ns
helm install prometheus-rel prometheus-community/prometheus --create-namespace -n prometheus-ns -f ../config/values-prometheus.yml

# Installe repo Grafana (et Loki)
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana-rel grafana/grafana --create-namespace -n grafana-ns -f ../config/values-grafana.yml

helm repo add vm https://victoriametrics.github.io/helm-charts
helm repo update
helm install vm-rel vm/victoria-metrics-single --create-namespace -n vm-ns
# helm install loki-rel grafana/loki --create-namespace -n loki-rel
