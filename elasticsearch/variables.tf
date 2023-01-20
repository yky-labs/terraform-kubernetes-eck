# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

variable "name" {
  type        = string
  description = "The Elasticsearch cluster name."
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace."
}

variable "create_namespace" {
  type        = bool
  description = "Create the Kunernetes namespace."
  default     = false
}

variable "elasticsearch_version" {
  type        = string
  description = "Elasticsearch version."
}

variable "license" {
  type        = string
  description = "Elasticsearch license."
  default     = "basic"
}

variable "labels" {
  type        = map(string)
  description = "Labels that will be applied to Elasticsearch."
  default     = null
}

variable "annotations" {
  type        = map(string)
  description = "Annotations that will be applied to Elasticsearch."
  default     = null
}

variable "auth" {
  type        = any
  description = <<-EOF
    Settings for configuring Elasticsearch users and roles.
    https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-users-and-roles.html
  EOF
  default     = null
}

variable "monitoring" {
  type        = any
  description = <<-EOF
    Settings for configuring stack monitoring.
    https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-stack-monitoring.html
  EOF
  default     = null
}

variable "transport" {
  type        = any
  description = <<-EOF
    Control the Elasticsearch transport module used for internal communication between nodes.
    https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-transport-settings.html
  EOF
  default     = null
}

variable "http" {
  type        = any
  description = <<-EOF
    Settings to control how Elasticsearch will be accessed.
    https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-accessing-elastic-services.html
  EOF
  default     = null
}

variable "secureSettings" {
  type        = any
  description = <<-EOF
    Control Elasticsearch Secure Settings.
    https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-es-secure-settings.html#k8s-es-secure-settings
  EOF
  default     = null
}

variable "updateStrategy" {
  type        = any
  description = <<-EOF
    Settings for limiting the number of simultaneous changes to an Elasticsearch resource.
    https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-update-strategy.html
  EOF
  default     = null
}

variable "remoteClusters" {
  type        = any
  description = <<-EOF
    Controlling of connectivity between remote clusters within the same kubernetes cluster.
    https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-remote-clusters.html
  EOF
  default     = null
}

variable "nodeset_default_count" {
  type        = number
  description = "Default nodeset count."
  default     = 1
}
