### For connecting and provisioning
variable "region" {
  default = "us-west-2"
}
provider "aws" {
  region = var.region
  # Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

# This specifies the disk size of each node in your ES cluster (created elsewhere)
variable "elasticsearch_disk_size" {
  default = 20
}

# This specifies number of nodes in your ES cluster (created elsewhere)
variable "elasticsearch_instance_count" {
  default = 2
}


module "es_alarms" {
  source           = "../../"
  domain_name      = "example"
  sns_topic        = "elasticsearch-threshold-alerts"
  sns_topic_prefix = "prod-"
  # You should always specify how big your ES cluster's disk size is.  Using this calculation of (size-in-gb * instance count * GB-to-MB * 20%) because 20% is the best-practice for low disk, per AWS's recommendations
  free_storage_space_threshold = var.elasticsearch_disk_size * var.elasticsearch_instance_count * 1024 * 0.20
  # Use this if using KMS on your ElasticSearch
  monitor_kms = true
  # Use these to monitor how many nodes are available and that they are all functional
  min_available_nodes = var.elasticsearch_instance_count
  # Use this to monitor high CPU on your masters (if using masters)
  monitor_master_cpu_utilization_too_high = true
  # Use this to monitor high memory on your masters (if using masters)
  monitor_master_jvm_memory_pressure_too_high = true
}

output "es_alarms_sns_topic_arn" {
  value = module.es_alarms.sns_topic_arn
}
