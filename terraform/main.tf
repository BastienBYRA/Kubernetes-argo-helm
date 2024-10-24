provider "helm" {
    kubernetes {
        config_path = "~/.kube/config"
    }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo/argo-cd"
}

resource "helm_release" "kube_state_metrics" {
  name       = "kube_state_metrics"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-community/kube-state-metrics"
}

resource "helm_release" "prometheus" {
  depends_on = [helm_release.kube_state_metrics]
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-community/prometheus"
  values = [
    "${file("../config/values-prometheus.yml")}"
  ]
}

resource "helm_release" "grafana" {
  depends_on = [helm_release.prometheus]
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana/grafana"
  values = [
    "${file("../config/values-grafana.yml")}"
  ]
}