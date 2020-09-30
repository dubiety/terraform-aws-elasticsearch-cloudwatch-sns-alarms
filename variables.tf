variable "domain_name" {
  description = "The Elasticserach domain name you want to monitor."
  type        = string
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

variable "monitor_insufficient_available_nodes" {
  description = "Enable monitoring insufficient available nodes"
  type        = bool
  default     = false
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

variable "free_storage_space_threshold" {
  description = "The minimum amount of available storage space in MegaByte."
  type        = number
  default     = 20480 ## 20 Gigabyte in MegaByte
}

variable "min_available_nodes" {
  description = "The minimum available (reachable) nodes to have"
  type        = number
  default     = 1
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
