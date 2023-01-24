# (c) 2023 yky-labs
# This code is licensed under MIT license (see LICENSE for details)

variable "name" {
  type        = string
  description = "The Kibana deploy name."
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

variable "kibana_version" {
  type        = string
  description = "Kibana version."
}

variable "elasticsearch_ref" {
  type        = string
  description = "Elasticsearch cluster name."
}
