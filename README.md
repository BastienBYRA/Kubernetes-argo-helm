# Kubernetes / Helm

## Commande
- helm search repo <name>

## Prometheus et Kube State metrics
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install ksm-rel prometheus-community/kube-state-metrics --create-namespace -n ksm-ns
helm install prometheus-rel prometheus-community/prometheus --create-namespace -n prometheus-ns -f ./values-prometheus.yml

## Grafana
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana-rel grafana/grafana --create-namespace -n grafana-ns -f ./values-grafana.yml

## Victoria Metrics
helm repo add vm https://victoriametrics.github.io/helm-charts
helm repo update
helm install vm-rel vm/victoria-metrics-single --create-namespace -n vm-ns

## ArgoCD
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm install argocd-rel argo/argo-cd --create-namespace -n argocd-ns