provider "helm" {
    kubernetes {
        config_path = "~/.kube/config"
    }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  create_namespace = true
  namespace = "argocd"
}

resource "helm_release" "kube_state_metrics_argo_chart" {
  name       = "kube-state-metrics"
  chart      = "../modules/kube-state-metrics"
  create_namespace = true
  namespace = "ksm"
}

resource "helm_release" "prometheus_argo_chart" {
  name       = "prometheus"
  chart      = "../modules/prometheus"
  create_namespace = true
  namespace = "prometheus"
}

resource "helm_release" "grafana_argo_chart" {
  name       = "grafana"
  chart      = "../modules/grafana"
  create_namespace = true
  namespace = "grafana"
}

resource "helm_release" "loki_stack_argo_chart" {
  name       = "loki-stack"
  chart      = "../modules/loki-stack"
  create_namespace = true
  namespace = "loki-stack"
}





# resource "helm_release" "kube_state_metrics" {
#   name       = "kube-state-metrics"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart      = "kube-state-metrics"
#   create_namespace = true
#   namespace = "ksm"
# }

# resource "helm_release" "prometheus" {
#   depends_on = [helm_release.kube_state_metrics]
#   name       = "prometheus"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart      = "prometheus"
#   values = [
#     "${file("../config/values-prometheus.yml")}"
#   ]
#   create_namespace = true
#   namespace = "prometheus"
# }

# resource "helm_release" "grafana" {
#   depends_on = [helm_release.prometheus]
#   name       = "grafana"
#   repository = "https://grafana.github.io/helm-charts"
#   chart      = "grafana"
#   values = [
#     "${file("../config/values-grafana.yml")}"
#   ]
#   create_namespace = true
#   namespace = "grafana"
# }