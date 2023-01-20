# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

locals {
  namespace = (var.create_namespace) ? kubernetes_namespace_v1.this[0].metadata[0].name : var.namespace
}

resource "kubernetes_namespace_v1" "this" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace
  }
}

# https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-install-helm.html
# https://github.com/elastic/cloud-on-k8s

resource "helm_release" "this" {
  namespace  = local.namespace
  repository = "https://helm.elastic.co"
  chart      = "eck-operator"
  name       = var.name
  version    = var.chart_version
  values = concat([
    <<-EOF
    EOF
  ], var.chart_values)

  depends_on = [
    kubernetes_namespace_v1.this
  ]
}
