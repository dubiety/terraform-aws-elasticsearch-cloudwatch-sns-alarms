data "aws_caller_identity" "default" {}

# Make a topic
resource "aws_sns_topic" "default_prefix" {
  count       = var.sns_topic == "" && var.create_sns_topic == true ? 1 : 0
  name_prefix = "${var.sns_topic_prefix}elasticsearch-threshold-alerts${var.sns_topic_postfix}"
  tags        = var.tags
}

resource "aws_sns_topic" "default" {
  count = var.sns_topic != "" && var.create_sns_topic == true ? 1 : 0
  name  = "${var.sns_topic_prefix}${var.sns_topic}${var.sns_topic_postfix}"
  tags  = var.tags
}

locals {
  aws_sns_topic_arn = coalesce(
    element(
      concat(
        aws_sns_topic.default_prefix.*.arn,
        [""],
      ),
      0,
    ),
    element(
      concat(
        aws_sns_topic.default.*.arn,
        [""],
      ),
      0,
    ),
    var.sns_topic
  )
  aws_sns_topic_name = element(split(":", local.aws_sns_topic_arn), 5)
}

resource "aws_sns_topic_policy" "default" {
  count  = var.create_sns_topic == true ? 1 : 0
  arn    = local.aws_sns_topic_arn
  policy = data.aws_iam_policy_document.sns_topic_policy[0].json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  count     = var.create_sns_topic == true ? 1 : 0
  policy_id = "__default_policy_ID"

  statement {
    sid = "__default_statement_ID"

    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    effect    = "Allow"
    resources = [local.aws_sns_topic_arn]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        data.aws_caller_identity.default.account_id,
      ]
    }
  }

  statement {
    sid       = "Allow CloudwatchEvents"
    actions   = ["sns:Publish"]
    resources = [local.aws_sns_topic_arn]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }

  statement {
    sid       = "Allow ES Event Notification"
    actions   = ["sns:Publish"]
    resources = [local.aws_sns_topic_arn]

    principals {
      type        = "Service"
      identifiers = ["es.amazonaws.com"]
    }
  }
}
