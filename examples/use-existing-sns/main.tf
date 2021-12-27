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

# Create an existing SNS topic (aka, do not create in module)
resource "aws_sns_topic" "this" {
  name = "using-existing-sns-topic-test"
}

module "es_alarms" {
  source      = "../../"
  domain_name = "example"
  # To use an existing SNS topic, your `sns_topic` MUST be a full ARN
  # And you must set `create_sns_topic` to false
  sns_topic        = var.aws_sns_topic.arn
  create_sns_topic = false
}

output "es_alarms_sns_topic_arn" {
  value = module.es_alarms.sns_topic_arn
}
