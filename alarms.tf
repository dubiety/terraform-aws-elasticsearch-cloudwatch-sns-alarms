locals {
  thresholds = {
    FreeStorageSpaceThreshold        = max(var.free_storage_space_threshold, 0)
    MinimumAvailableNodes            = max(var.min_available_nodes, 0)
    CPUUtilizationThreshold          = min(max(var.cpu_utilization_threshold, 0), 100)
    JVMMemoryPressureThreshold       = min(max(var.jvm_memory_pressure_threshold, 0), 100)
    MasterCPUUtilizationThreshold    = min(max(coalesce(var.master_cpu_utilization_threshold, var.cpu_utilization_threshold), 0), 100)
    MasterJVMMemoryPressureThreshold = min(max(coalesce(var.master_jvm_memory_pressure_threshold, var.jvm_memory_pressure_threshold), 0), 100)
  }
}

resource "aws_cloudwatch_metric_alarm" "cluster_status_is_red" {
  count               = var.monitor_cluster_status_is_red ? 1 : 0
  alarm_name          = "${var.alarm_name_prefix}ElasticSearch-ClusterStatusIsRed${var.alarm_name_postfix}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ClusterStatus.red"
  namespace           = "AWS/ES"
  period              = var.monitor_cluster_status_is_red_period
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "Average elasticsearch cluster status is in red over last 1 minute"
  alarm_actions       = [local.aws_sns_topic_arn]
  ok_actions          = [local.aws_sns_topic_arn]
  treat_missing_data  = "ignore"
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    ClientId   = data.aws_caller_identity.default.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "cluster_status_is_yellow" {
  count               = var.monitor_cluster_status_is_yellow ? 1 : 0
  alarm_name          = "${var.alarm_name_prefix}ElasticSearch-ClusterStatusIsYellow${var.alarm_name_postfix}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.alarm_cluster_status_is_yellow_periods
  metric_name         = "ClusterStatus.yellow"
  namespace           = "AWS/ES"
  period              = var.monitor_cluster_status_is_yellow_period
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "Average elasticsearch cluster status is in yellow over last ${var.alarm_cluster_status_is_yellow_periods} minute(s)"
  alarm_actions       = [local.aws_sns_topic_arn]
  ok_actions          = [local.aws_sns_topic_arn]
  treat_missing_data  = "ignore"
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    ClientId   = data.aws_caller_identity.default.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "free_storage_space_too_low" {
  count               = var.monitor_free_storage_space_too_low ? 1 : 0
  alarm_name          = "${var.alarm_name_prefix}ElasticSearch-FreeStorageSpaceTooLow${var.alarm_name_postfix}"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.alarm_free_storage_space_too_low_periods
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/ES"
  period              = var.monitor_free_storage_space_too_low_period
  statistic           = "Minimum"
  threshold           = local.thresholds["FreeStorageSpaceThreshold"]
  alarm_description   = "Average elasticsearch free storage space over last ${var.alarm_free_storage_space_too_low_periods} minute(s) is too low"
  alarm_actions       = [local.aws_sns_topic_arn]
  ok_actions          = [local.aws_sns_topic_arn]
  treat_missing_data  = "ignore"
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    ClientId   = data.aws_caller_identity.default.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "cluster_index_writes_blocked" {
  count               = var.monitor_cluster_index_writes_blocked ? 1 : 0
  alarm_name          = "${var.alarm_name_prefix}ElasticSearch-ClusterIndexWritesBlocked${var.alarm_name_postfix}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ClusterIndexWritesBlocked"
  namespace           = "AWS/ES"
  period              = var.monitor_cluster_index_writes_blocked_period
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "Elasticsearch index writes being blocker over last 5 minutes"
  alarm_actions       = [local.aws_sns_topic_arn]
  ok_actions          = [local.aws_sns_topic_arn]
  treat_missing_data  = "ignore"
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    ClientId   = data.aws_caller_identity.default.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "insufficient_available_nodes" {
  count               = var.min_available_nodes > 0 ? 1 : 0
  alarm_name          = "${var.alarm_name_prefix}ElasticSearch-InsufficientAvailableNodes${var.alarm_name_postfix}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "Nodes"
  namespace           = "AWS/ES"
  period              = var.monitor_min_available_nodes_period
  statistic           = "Minimum"
  threshold           = local.thresholds["MinimumAvailableNodes"]
  alarm_description   = "Elasticsearch nodes minimum < ${local.thresholds["MinimumAvailableNodes"]} for 1 day"
  alarm_actions       = [local.aws_sns_topic_arn]
  ok_actions          = [local.aws_sns_topic_arn]
  treat_missing_data  = "ignore"
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    ClientId   = data.aws_caller_identity.default.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "automated_snapshot_failure" {
  count               = var.monitor_automated_snapshot_failure ? 1 : 0
  alarm_name          = "${var.alarm_name_prefix}ElasticSearch-AutomatedSnapshotFailure${var.alarm_name_postfix}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "AutomatedSnapshotFailure"
  namespace           = "AWS/ES"
  period              = var.monitor_automated_snapshot_failure_period
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "Elasticsearch automated snapshot failed over last 1 minute"
  alarm_actions       = [local.aws_sns_topic_arn]
  ok_actions          = [local.aws_sns_topic_arn]
  treat_missing_data  = "ignore"
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    ClientId   = data.aws_caller_identity.default.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_too_high" {
  count               = var.monitor_cpu_utilization_too_high ? 1 : 0
  alarm_name          = "${var.alarm_name_prefix}ElasticSearch-CPUUtilizationTooHigh${var.alarm_name_postfix}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ES"
  period              = var.monitor_cpu_utilization_too_high_period
  statistic           = "Average"
  threshold           = local.thresholds["CPUUtilizationThreshold"]
  alarm_description   = "Average elasticsearch cluster CPU utilization over last 45 minutes too high"
  alarm_actions       = [local.aws_sns_topic_arn]
  ok_actions          = [local.aws_sns_topic_arn]
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    ClientId   = data.aws_caller_identity.default.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "jvm_memory_pressure_too_high" {
  count               = var.monitor_jvm_memory_pressure_too_high ? 1 : 0
  alarm_name          = "${var.alarm_name_prefix}ElasticSearch-JVMMemoryPressure${var.alarm_name_postfix}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "JVMMemoryPressure"
  namespace           = "AWS/ES"
  period              = var.monitor_jvm_memory_pressure_too_high_period
  statistic           = "Maximum"
  threshold           = local.thresholds["JVMMemoryPressureThreshold"]
  alarm_description   = "Elasticsearch JVM memory pressure is too high over last 15 minutes"
  alarm_actions       = [local.aws_sns_topic_arn]
  ok_actions          = [local.aws_sns_topic_arn]
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    ClientId   = data.aws_caller_identity.default.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "master_cpu_utilization_too_high" {
  count               = var.monitor_master_cpu_utilization_too_high ? 1 : 0
  alarm_name          = "${var.alarm_name_prefix}ElasticSearch-MasterCPUUtilizationTooHigh${var.alarm_name_postfix}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "MasterCPUUtilization"
  namespace           = "AWS/ES"
  period              = var.monitor_master_cpu_utilization_too_high_period
  statistic           = "Average"
  threshold           = local.thresholds["MasterCPUUtilizationThreshold"]
  alarm_description   = "Average elasticsearch cluster CPU utilization over last 45 minutes too high"
  alarm_actions       = [local.aws_sns_topic_arn]
  ok_actions          = [local.aws_sns_topic_arn]
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    ClientId   = data.aws_caller_identity.default.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "master_jvm_memory_pressure_too_high" {
  count               = var.monitor_master_jvm_memory_pressure_too_high ? 1 : 0
  alarm_name          = "${var.alarm_name_prefix}ElasticSearch-MasterJVMMemoryPressure${var.alarm_name_postfix}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "MasterJVMMemoryPressure"
  namespace           = "AWS/ES"
  period              = var.monitor_master_jvm_memory_pressure_too_high_period
  statistic           = "Maximum"
  threshold           = local.thresholds["MasterJVMMemoryPressureThreshold"]
  alarm_description   = "Elasticsearch JVM memory pressure is too high over last 15 minutes"
  alarm_actions       = [local.aws_sns_topic_arn]
  ok_actions          = [local.aws_sns_topic_arn]
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    ClientId   = data.aws_caller_identity.default.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "kms_key_error" {
  count               = var.monitor_kms ? 1 : 0
  alarm_name          = "${var.alarm_name_prefix}ElasticSearch-KMSKeyError${var.alarm_name_postfix}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "KMSKeyError"
  namespace           = "AWS/ES"
  period              = var.monitor_kms_period
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "Elasticsearch KMS Key Error failed over last 1 minute"
  alarm_actions       = [local.aws_sns_topic_arn]
  ok_actions          = [local.aws_sns_topic_arn]
  treat_missing_data  = "ignore"
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    ClientId   = data.aws_caller_identity.default.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "kms_key_inaccessible" {
  count               = var.monitor_kms ? 1 : 0
  alarm_name          = "${var.alarm_name_prefix}ElasticSearch-KMSKeyInaccessible${var.alarm_name_postfix}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "KMSKeyInaccessible"
  namespace           = "AWS/ES"
  period              = var.monitor_kms_period
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "Elasticsearch KMS Key Inaccessible failed over last 1 minute"
  alarm_actions       = [local.aws_sns_topic_arn]
  ok_actions          = [local.aws_sns_topic_arn]
  treat_missing_data  = "ignore"
  tags                = var.tags

  dimensions = {
    DomainName = var.domain_name
    ClientId   = data.aws_caller_identity.default.account_id
  }
}
