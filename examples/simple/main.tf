### For connecting and provisioning
variable "region" {
  type    = string
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

module "es_alarms" {
  source              = "../../"
  domain_name         = "example"
  sns_topic           = "elasticsearch-threshold-alerts"
  sns_topic_prefix    = "prod-"
  min_available_nodes = "3"
}

output "es_alarms_sns_topic_arn" {
  value = module.es_alarms.sns_topic_arn
}
