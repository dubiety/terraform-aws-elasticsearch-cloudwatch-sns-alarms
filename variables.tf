variable "domain_name" {
  description = "The Elasticserach domain name you want to monitor."
  type        = string
}

variable "cluster_type" {
  description = "The type of cluster, single or multi-node"
  type        = string
  default     = "single"
  validation {
    condition     = contains(["single", "multi"], var.cluster_type)
    error_message = "Valid values for variable: cluster_type are (single, multi)."
  }
}

variable "create_sns_topic" {
  description = "If you don't want to create the SNS topic, set this to false.  It will use the sns_topic value directly"
  type        = bool
  default     = true
}

variable "sns_topic" {
  description = "SNS topic you want to specify. If leave empty, it will use a prefix and a timestampe appended"
  type        = string
  default     = ""
}

variable "alarm_name_prefix" {
  description = "Alarm name prefix"
  type        = string
  default     = ""
}

variable "alarm_name_postfix" {
  description = "Alarm name postfix"
  type        = string
  default     = ""
}

variable "sns_topic_prefix" {
  description = "SNS topic prefix"
  type        = string
  default     = ""
}

variable "sns_topic_postfix" {
  description = "SNS topic postfix"
  type        = string
  default     = ""
}

variable "monitor_cluster_status_is_red" {
  description = "Enable monitoring of cluster status is in red"
  type        = bool
  default     = true
}

variable "monitor_cluster_status_is_yellow" {
  description = "Enable monitoring of cluster status is in yellow"
  type        = bool
  default     = true
}

variable "monitor_free_storage_space_too_low" {
  description = "Enable monitoring of cluster average free storage is to low"
  type        = bool
  default     = true
}

variable "monitor_cluster_index_writes_blocked" {
  description = "Enable monitoring of cluster index writes being blocked"
  type        = bool
  default     = true
}

variable "monitor_automated_snapshot_failure" {
  description = "Enable monitoring of automated snapshot failure"
  type        = bool
  default     = true
}

variable "monitor_cpu_utilization_too_high" {
  description = "Enable monitoring of CPU utilization is too high"
  type        = bool
  default     = true
}

variable "monitor_jvm_memory_pressure_too_high" {
  description = "Enable monitoring of JVM memory pressure is too high"
  type        = bool
  default     = true
}

variable "monitor_kms" {
  description = "Enable monitoring of KMS-related metrics.  Only enable this when using KMS with ElasticSearch"
  type        = bool
  default     = false
}

variable "monitor_master_cpu_utilization_too_high" {
  description = "Enable monitoring of CPU utilization of master nodes are too high. Only enable this when dedicated master is enabled"
  type        = bool
  default     = false
}

variable "monitor_master_jvm_memory_pressure_too_high" {
  description = "Enable monitoring of JVM memory pressure of master nodes are too high. Only enable this wwhen dedicated master is enabled"
  type        = bool
  default     = false
}

variable "monitor_min_available_nodes_period" {
  description = "The period of the minimum available nodes should the statistics be applied in seconds"
  type        = string
  default     = "86400"
}

variable "monitor_cluster_status_is_red_period" {
  description = "The period of the cluster status is in red should the statistics be applied in seconds"
  type        = string
  default     = "60"
}

variable "monitor_cluster_status_is_yellow_period" {
  description = "The period of the cluster status is in yellow should the statistics be applied in seconds"
  type        = string
  default     = "60"
}

variable "monitor_free_storage_space_too_low_period" {
  description = "The period of the cluster average free storage is too low should the statistics be applied in seconds"
  type        = string
  default     = "60"
}

variable "monitor_cluster_index_writes_blocked_period" {
  description = "The period of the cluster index writes being blocked should the statistics be applied in seconds"
  type        = string
  default     = "300"
}

variable "monitor_automated_snapshot_failure_period" {
  description = "The period of the automated snapshot failure should the statistics be applied in seconds"
  type        = string
  default     = "60"
}

variable "monitor_cpu_utilization_too_high_period" {
  description = "The period of the CPU utilization is too high should the statistics be applied in seconds"
  type        = string
  default     = "900"
}

variable "monitor_jvm_memory_pressure_too_high_period" {
  description = "The period of the JVM memory pressure is too high should the statistics be applied in seconds"
  type        = string
  default     = "900"
}

variable "monitor_kms_period" {
  description = "The period of the KMS-related metrics should the statistics be applied in seconds"
  type        = string
  default     = "60"
}

variable "monitor_master_cpu_utilization_too_high_period" {
  description = "The period of the CPU utilization of master nodes are too high should the statistics be applied in seconds"
  type        = string
  default     = "900"
}

variable "monitor_master_jvm_memory_pressure_too_high_period" {
  description = "The period of the JVM memory pressure of master nodes are too high should the statistics be applied in seconds"
  type        = string
  default     = "900"
}

variable "free_storage_space_threshold" {
  description = "The minimum amount of available storage space in MegaByte."
  type        = number
  default     = 20480 ## 20 Gigabyte in MegaByte
}

variable "min_available_nodes" {
  description = "The minimum available (reachable) nodes to have, set to non-zero to enable"
  type        = number
  default     = 0
}

variable "cpu_utilization_threshold" {
  description = "The maximum percentage of CPU utilization"
  type        = number
  default     = 80

  # 80 percent in Percentage
}

variable "jvm_memory_pressure_threshold" {
  description = "The maximum percentage of the Java heap used for all data nodes in the cluster"
  type        = number
  default     = 80

  # 80 percent in Percentage
}

variable "master_cpu_utilization_threshold" {
  description = "The maximum percentage of CPU utilization of master nodes"
  type        = number
  default     = 80 # default same as `cpu_utilization_threshold` in Percentage


}

variable "master_jvm_memory_pressure_threshold" {
  description = "The maximum percentage of the Java heap used for master nodes in the cluster"
  type        = number
  default     = 80 # default same as `jvm_memory_pressure_threshold` in Percentage


}

variable "alarm_cluster_status_is_yellow_periods" {
  description = "The number of periods to alert that cluster status is yellow.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period"
  type        = number
  default     = 1
}

variable "alarm_free_storage_space_too_low_periods" {
  description = "The number of periods to alert that cluster free storage space is too low.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period"
  type        = number
  default     = 1
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
