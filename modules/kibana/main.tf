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

# https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-kibana.html
# https://github.com/elastic/cloud-on-k8s/blob/main/config/samples/kibana/kibana_es.yaml

resource "kubectl_manifest" "this" {
  yaml_body = <<-EOF
    apiVersion: kibana.k8s.elastic.co/v1
    kind: Kibana
    metadata:
      name: ${var.name}
      namespace: ${local.namespace}
    spec:
      version: ${var.kibana_version}
      count: 1
      elasticsearchRef:
        name: ${var.elasticsearch_ref}
  EOF

}
