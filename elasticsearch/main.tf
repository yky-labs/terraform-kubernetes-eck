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

# https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-elasticsearch.html
# https://github.com/elastic/cloud-on-k8s/blob/main/config/samples/elasticsearch/elasticsearch.yaml

resource "kubectl_manifest" "this" {
  yaml_body = <<-EOF
    apiVersion: elasticsearch.k8s.elastic.co/v1
    kind: Elasticsearch
    metadata:
      name: ${var.name}
      namespace: ${var.namespace}
      %{~ if var.labels != null ~}
      labels:
        ${indent(8, yamlencode(var.labels))}
      %{~ endif ~}
      annotations:
        eck.k8s.elastic.co/license: ${var.license}
        %{~ if var.annotations != null ~}
        ${indent(8, yamlencode(var.annotations))}
        %{~ endif ~}
    spec:
      version: ${var.elasticsearch_version}
      
      %{~ if var.auth != null ~}
      auth:
        ${indent(4, yamlencode(var.auth))}
      %{~ endif ~}
      
      %{~ if var.monitoring != null ~}
      monitoring:
        ${indent(4, yamlencode(var.monitoring))}
      %{~ endif ~}

      %{~ if var.transport != null ~}
      transport:
        ${indent(4, yamlencode(var.transport))}
      %{~ endif ~}

      %{~ if var.http != null ~}
      http:
        ${indent(4, yamlencode(var.http))}
      %{~ endif ~}

      %{~ if var.secureSettings != null ~}
      secureSettings:
        ${indent(4, yamlencode(var.secureSettings))}
      %{~ endif ~}

      %{~ if var.updateStrategy != null ~}
      updateStrategy:
        ${indent(4, yamlencode(var.updateStrategy))}
      %{~ endif ~}

      %{~ if var.remoteClusters != null ~}
      remoteClusters:
        ${indent(4, yamlencode(var.remoteClusters))}
      %{~ endif ~}

      nodeSets:
      - name: default
        count: ${var.nodeset_default_count}
        config:
          node.store.allow_mmap: false

  EOF

}
