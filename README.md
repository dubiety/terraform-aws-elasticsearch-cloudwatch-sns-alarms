# terraform-aws-elasticsearch-cloudwatch-sns-alarms

[![Build Status](https://travis-ci.com/dubiety/terraform-aws-elasticsearch-cloudwatch-sns-alarms.svg?branch=master)](https://app.travis-ci.com/github/dubiety/terraform-aws-elasticsearch-cloudwatch-sns-alarms)
[![Latest Release](https://img.shields.io/github/release/dubiety/terraform-aws-elasticsearch-cloudwatch-sns-alarms.svg)](https://github.com/dubiety/terraform-aws-elasticsearch-cloudwatch-sns-alarms/releases)

Terraform module that configures the [recommended Amazon ElasticSearch Alarms](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/cloudwatch-alarms.html) using CloudWatch and sends alerts to an SNS topic.  By default, this module creates an SNS topic, but it can be configured to point to an existing SNS topic (see [example](./examples/use-existing-sns/main.tf))

`v1.x` supports terraform `v0.12+` syntax!\
`v2.0+` supports terraform `v1.0+` syntax!

This project is inspired by [CloudPosse](https://github.com/cloudposse)\
It's 100% Open Source and licensed under the [APACHE2](LICENSE).

To commit to this repository, you must install [pre-commit](https://pre-commit.com/) and run `pre-commit install`.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.allocated_shards_too_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.automated_snapshot_failure](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cluster_index_writes_blocked](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cluster_status_is_red](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cluster_status_is_yellow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu_utilization_too_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.free_storage_space_too_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.free_storage_space_total_too_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.insufficient_available_nodes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.jvm_memory_pressure_too_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.kms_key_error](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.kms_key_inaccessible](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.master_cpu_utilization_too_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.master_jvm_memory_pressure_too_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_sns_topic.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic.default_prefix](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_caller_identity.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_allocated_shards_too_high_period"></a> [alarm\_allocated\_shards\_too\_high\_period](#input\_alarm\_allocated\_shards\_too\_high\_period) | The period of the available shards are too low should the statistics be applied in seconds | `number` | `900` | no |
| <a name="input_alarm_allocated_shards_too_high_periods"></a> [alarm\_allocated\_shards\_too\_high\_periods](#input\_alarm\_allocated\_shards\_too\_high\_periods) | The number of periods to alert that available shard count is too low.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period | `number` | `1` | no |
| <a name="input_alarm_automated_snapshot_failure_period"></a> [alarm\_automated\_snapshot\_failure\_period](#input\_alarm\_automated\_snapshot\_failure\_period) | The period of the automated snapshot failure should the statistics be applied in seconds | `number` | `60` | no |
| <a name="input_alarm_automated_snapshot_failure_periods"></a> [alarm\_automated\_snapshot\_failure\_periods](#input\_alarm\_automated\_snapshot\_failure\_periods) | The number of periods to alert that automatic snapshots failed.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period | `number` | `1` | no |
| <a name="input_alarm_cluster_index_writes_blocked_period"></a> [alarm\_cluster\_index\_writes\_blocked\_period](#input\_alarm\_cluster\_index\_writes\_blocked\_period) | The period of the cluster index writes being blocked should the statistics be applied in seconds | `number` | `300` | no |
| <a name="input_alarm_cluster_index_writes_blocked_periods"></a> [alarm\_cluster\_index\_writes\_blocked\_periods](#input\_alarm\_cluster\_index\_writes\_blocked\_periods) | The number of periods to alert that cluster index writes are blocked.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period | `number` | `1` | no |
| <a name="input_alarm_cluster_status_is_red_period"></a> [alarm\_cluster\_status\_is\_red\_period](#input\_alarm\_cluster\_status\_is\_red\_period) | The period of the cluster status is in red should the statistics be applied in seconds | `number` | `60` | no |
| <a name="input_alarm_cluster_status_is_red_periods"></a> [alarm\_cluster\_status\_is\_red\_periods](#input\_alarm\_cluster\_status\_is\_red\_periods) | The number of periods to alert that cluster status is red.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period | `number` | `1` | no |
| <a name="input_alarm_cluster_status_is_yellow_period"></a> [alarm\_cluster\_status\_is\_yellow\_period](#input\_alarm\_cluster\_status\_is\_yellow\_period) | The period of the cluster status is in yellow should the statistics be applied in seconds | `number` | `60` | no |
| <a name="input_alarm_cluster_status_is_yellow_periods"></a> [alarm\_cluster\_status\_is\_yellow\_periods](#input\_alarm\_cluster\_status\_is\_yellow\_periods) | The number of periods to alert that cluster status is yellow.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period | `number` | `1` | no |
| <a name="input_alarm_cpu_utilization_too_high_period"></a> [alarm\_cpu\_utilization\_too\_high\_period](#input\_alarm\_cpu\_utilization\_too\_high\_period) | The period of the CPU utilization is too high should the statistics be applied in seconds | `number` | `900` | no |
| <a name="input_alarm_cpu_utilization_too_high_periods"></a> [alarm\_cpu\_utilization\_too\_high\_periods](#input\_alarm\_cpu\_utilization\_too\_high\_periods) | The number of periods to alert that CPU usage is too high.  Default: 3, raise this to be less noisy, as this can occur often for only 1 period | `number` | `3` | no |
| <a name="input_alarm_free_storage_space_too_low_period"></a> [alarm\_free\_storage\_space\_too\_low\_period](#input\_alarm\_free\_storage\_space\_too\_low\_period) | The period of the per-node free storage is too low should the statistics be applied in seconds | `number` | `60` | no |
| <a name="input_alarm_free_storage_space_too_low_periods"></a> [alarm\_free\_storage\_space\_too\_low\_periods](#input\_alarm\_free\_storage\_space\_too\_low\_periods) | The number of periods to alert that the per-node free storage space is too low.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period | `number` | `1` | no |
| <a name="input_alarm_free_storage_space_total_too_low_period"></a> [alarm\_free\_storage\_space\_total\_too\_low\_period](#input\_alarm\_free\_storage\_space\_total\_too\_low\_period) | The period of the total cluster free storage is too low should the statistics be applied in seconds | `number` | `60` | no |
| <a name="input_alarm_free_storage_space_total_too_low_periods"></a> [alarm\_free\_storage\_space\_total\_too\_low\_periods](#input\_alarm\_free\_storage\_space\_total\_too\_low\_periods) | The number of periods to alert that total cluster free storage space is too low.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period | `number` | `1` | no |
| <a name="input_alarm_jvm_memory_pressure_too_high_period"></a> [alarm\_jvm\_memory\_pressure\_too\_high\_period](#input\_alarm\_jvm\_memory\_pressure\_too\_high\_period) | The period of the JVM memory pressure is too high should the statistics be applied in seconds | `number` | `900` | no |
| <a name="input_alarm_jvm_memory_pressure_too_high_periods"></a> [alarm\_jvm\_memory\_pressure\_too\_high\_periods](#input\_alarm\_jvm\_memory\_pressure\_too\_high\_periods) | The number of periods which it must be in the alarmed state to alert | `number` | `1` | no |
| <a name="input_alarm_kms_period"></a> [alarm\_kms\_period](#input\_alarm\_kms\_period) | The period of the KMS-related metrics should the statistics be applied in seconds | `number` | `60` | no |
| <a name="input_alarm_kms_periods"></a> [alarm\_kms\_periods](#input\_alarm\_kms\_periods) | The number of periods to alert that kms has failed.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period | `number` | `1` | no |
| <a name="input_alarm_master_cpu_utilization_too_high_period"></a> [alarm\_master\_cpu\_utilization\_too\_high\_period](#input\_alarm\_master\_cpu\_utilization\_too\_high\_period) | The period of the CPU utilization of master nodes are too high should the statistics be applied in seconds | `number` | `900` | no |
| <a name="input_alarm_master_cpu_utilization_too_high_periods"></a> [alarm\_master\_cpu\_utilization\_too\_high\_periods](#input\_alarm\_master\_cpu\_utilization\_too\_high\_periods) | The number of periods to alert that masters CPU usage is too high.  Default: 3, raise this to be less noisy, as this can occur often for only 1 period | `number` | `3` | no |
| <a name="input_alarm_master_jvm_memory_pressure_too_high_period"></a> [alarm\_master\_jvm\_memory\_pressure\_too\_high\_period](#input\_alarm\_master\_jvm\_memory\_pressure\_too\_high\_period) | The period of the JVM memory pressure of master nodes are too high should the statistics be applied in seconds | `number` | `900` | no |
| <a name="input_alarm_master_jvm_memory_pressure_too_high_periods"></a> [alarm\_master\_jvm\_memory\_pressure\_too\_high\_periods](#input\_alarm\_master\_jvm\_memory\_pressure\_too\_high\_periods) | The number of periods which it must be in the alarmed state to alert | `number` | `1` | no |
| <a name="input_alarm_min_available_nodes_period"></a> [alarm\_min\_available\_nodes\_period](#input\_alarm\_min\_available\_nodes\_period) | The period of the minimum available nodes should the statistics be applied in seconds | `number` | `86400` | no |
| <a name="input_alarm_min_available_nodes_periods"></a> [alarm\_min\_available\_nodes\_periods](#input\_alarm\_min\_available\_nodes\_periods) | The number of periods to alert that minimum number of available nodes dropped below a threshold.  Default: 1, raise this to be less noisy, as this can occur often for only 1 period | `number` | `1` | no |
| <a name="input_alarm_name_postfix"></a> [alarm\_name\_postfix](#input\_alarm\_name\_postfix) | Alarm name suffix, used in the naming of alarms created | `string` | `""` | no |
| <a name="input_alarm_name_prefix"></a> [alarm\_name\_prefix](#input\_alarm\_name\_prefix) | Alarm name prefix, used in the naming of alarms created | `string` | `""` | no |
| <a name="input_available_shards_threshold"></a> [available\_shards\_threshold](#input\_available\_shards\_threshold) | The minimum amount of available shards.  This is per-cluster. | `number` | `5400` | no |
| <a name="input_cpu_utilization_threshold"></a> [cpu\_utilization\_threshold](#input\_cpu\_utilization\_threshold) | The maximum percentage of CPU utilization | `number` | `80` | no |
| <a name="input_create_sns_topic"></a> [create\_sns\_topic](#input\_create\_sns\_topic) | If you don't want to create the SNS topic, set this to false.  It will use the sns\_topic value directly | `bool` | `true` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The Elasticsearch domain name you want to monitor | `string` | n/a | yes |
| <a name="input_free_storage_space_threshold"></a> [free\_storage\_space\_threshold](#input\_free\_storage\_space\_threshold) | The minimum amount of available storage space in megabytes.  This is per-node. | `number` | `20480` | no |
| <a name="input_free_storage_space_total_threshold"></a> [free\_storage\_space\_total\_threshold](#input\_free\_storage\_space\_total\_threshold) | The minimum amount of available storage space in megabytes aggregated across your cluster (for multi-node).  This is an aggregate, typically use (free\_storage\_space\_threshold * min\_available\_nodes) | `number` | `20480` | no |
| <a name="input_jvm_memory_pressure_threshold"></a> [jvm\_memory\_pressure\_threshold](#input\_jvm\_memory\_pressure\_threshold) | The maximum percentage of the Java heap used for all data nodes in the cluster | `number` | `80` | no |
| <a name="input_master_cpu_utilization_threshold"></a> [master\_cpu\_utilization\_threshold](#input\_master\_cpu\_utilization\_threshold) | The maximum percentage of CPU utilization of master nodes | `number` | `80` | no |
| <a name="input_master_jvm_memory_pressure_threshold"></a> [master\_jvm\_memory\_pressure\_threshold](#input\_master\_jvm\_memory\_pressure\_threshold) | The maximum percentage of the Java heap used for master nodes in the cluster | `number` | `80` | no |
| <a name="input_max_available_shards"></a> [max\_available\_shards](#input\_max\_available\_shards) | The Maximumn available shards per cluster, set to non-zero to enable | `number` | `0` | no |
| <a name="input_min_available_nodes"></a> [min\_available\_nodes](#input\_min\_available\_nodes) | The minimum available (reachable) nodes to have, set to non-zero to enable | `number` | `0` | no |
| <a name="input_monitor_allocated_shards_too_high"></a> [monitor\_allocated\_shards\_too\_high](#input\_monitor\_allocated\_shards\_too\_high) | Enable monitoring per-cluster available shards is too low | `bool` | `true` | no |
| <a name="input_monitor_automated_snapshot_failure"></a> [monitor\_automated\_snapshot\_failure](#input\_monitor\_automated\_snapshot\_failure) | Enable monitoring of automated snapshot failure | `bool` | `true` | no |
| <a name="input_monitor_cluster_index_writes_blocked"></a> [monitor\_cluster\_index\_writes\_blocked](#input\_monitor\_cluster\_index\_writes\_blocked) | Enable monitoring of cluster index writes being blocked | `bool` | `true` | no |
| <a name="input_monitor_cluster_status_is_red"></a> [monitor\_cluster\_status\_is\_red](#input\_monitor\_cluster\_status\_is\_red) | Enable monitoring of cluster status is in red | `bool` | `true` | no |
| <a name="input_monitor_cluster_status_is_yellow"></a> [monitor\_cluster\_status\_is\_yellow](#input\_monitor\_cluster\_status\_is\_yellow) | Enable monitoring of cluster status is in yellow | `bool` | `true` | no |
| <a name="input_monitor_cpu_utilization_too_high"></a> [monitor\_cpu\_utilization\_too\_high](#input\_monitor\_cpu\_utilization\_too\_high) | Enable monitoring of CPU utilization is too high | `bool` | `true` | no |
| <a name="input_monitor_free_storage_space_too_low"></a> [monitor\_free\_storage\_space\_too\_low](#input\_monitor\_free\_storage\_space\_too\_low) | Enable monitoring of cluster per-node free storage is too low | `bool` | `true` | no |
| <a name="input_monitor_free_storage_space_total_too_low"></a> [monitor\_free\_storage\_space\_total\_too\_low](#input\_monitor\_free\_storage\_space\_total\_too\_low) | Enable monitoring of cluster total free storage is too low.  Disabled by default, if you set this you must set free\_storage\_space\_total\_threshold also | `bool` | `false` | no |
| <a name="input_monitor_jvm_memory_pressure_too_high"></a> [monitor\_jvm\_memory\_pressure\_too\_high](#input\_monitor\_jvm\_memory\_pressure\_too\_high) | Enable monitoring of JVM memory pressure is too high | `bool` | `true` | no |
| <a name="input_monitor_kms"></a> [monitor\_kms](#input\_monitor\_kms) | Enable monitoring of KMS-related metrics.  Only enable this when using KMS with ElasticSearch | `bool` | `false` | no |
| <a name="input_monitor_master_cpu_utilization_too_high"></a> [monitor\_master\_cpu\_utilization\_too\_high](#input\_monitor\_master\_cpu\_utilization\_too\_high) | Enable monitoring of CPU utilization of master nodes are too high. Only enable this when dedicated master is enabled | `bool` | `false` | no |
| <a name="input_monitor_master_jvm_memory_pressure_too_high"></a> [monitor\_master\_jvm\_memory\_pressure\_too\_high](#input\_monitor\_master\_jvm\_memory\_pressure\_too\_high) | Enable monitoring of JVM memory pressure of master nodes are too high. Only enable this wwhen dedicated master is enabled | `bool` | `false` | no |
| <a name="input_monitor_min_available_nodes"></a> [monitor\_min\_available\_nodes](#input\_monitor\_min\_available\_nodes) | Enable monitoring of minimum available nodes | `bool` | `true` | no |
| <a name="input_sns_topic"></a> [sns\_topic](#input\_sns\_topic) | SNS topic you want to specify. If leave empty, it will use a prefix and a timestampe appended | `string` | `""` | no |
| <a name="input_sns_topic_postfix"></a> [sns\_topic\_postfix](#input\_sns\_topic\_postfix) | SNS topic suffix, only used if you're creating an SNS topic | `string` | `""` | no |
| <a name="input_sns_topic_prefix"></a> [sns\_topic\_prefix](#input\_sns\_topic\_prefix) | SNS topic prefix, only used if you're creating an SNS topic | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | The ARN of the SNS topic |
| <a name="output_sns_topic_name"></a> [sns\_topic\_name](#output\_sns\_topic\_name) | The SNS topic name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
