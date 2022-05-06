#-------------------------------------
# Account ID & Region
#-------------------------------------

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

#-------------------------------------
# IAM Policy
#-------------------------------------

#-------------------------------------
# dbt_ecs_task_001
# Attach to ECS Task Role
data "aws_iam_policy_document" "dbt_ecs_task_001" {
  statement {
    sid       = "SSMPrameterStore"
    effect    = "Allow"
    actions   = [
      "ssm:GetParameter"
    ]
    resources = [
      "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${var.iam_dbt_ecs_001_resource_parameter_prefix}/*"
    ]
  }
  statement {
    sid       = "S3BucketForDocuments"
    effect    = "Allow"
    actions   = [
      "s3:ListBucket",
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${var.iam_dbt_ecs_001_resource_bucket_name}",
      "arn:aws:s3:::${var.iam_dbt_ecs_001_resource_bucket_name}/*"
    ]
  }
}

resource "aws_iam_policy" "dbt_ecs_task_001" {
  name        = var.iam_policy_name_dbt_ecs_task_001
  path        = var.iam_policy_path_dbt_ecs_task_001
  description = "dbt ecs task policy"

  policy = data.aws_iam_policy_document.dbt_ecs_task_001.json
}

#-------------------------------------
# dbt_ecs_exec_001
# Attach to ECS Task Execution Role
data "aws_iam_policy_document" "dbt_ecs_task_exec_001" {
  statement {
    sid       = "ECSTaskExecution"
    effect    = "Allow"
    actions   = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "dbt_ecs_task_exec_001" {
  name        = var.iam_policy_name_dbt_ecs_task_exec_001
  path        = var.iam_policy_path_dbt_ecs_task_exec_001
  description = "dbt ecs task execution policy"

  policy = data.aws_iam_policy_document.dbt_ecs_task_exec_001.json
}

#-------------------------------------
# dbt_ecs_stepfunctions_001
# Attach to Step Functions
data "aws_iam_policy_document" "dbt_ecs_stepfunctions_001_ecs" {
  statement {
    sid       = "RunESCTask"
    effect    = "Allow"
    actions   = [
      "ecs:RunTask"
    ]
    resources = [
      "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:task-definition/${var.dbt_ecs_task_prefix}"
    ]
  }
  statement {
    sid       = "StopECSTask"
    effect    = "Allow"
    actions   = [
      "ecs:StopTask",
      "ecs:DescribeTasks"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid       = "EventsRule"
    effect    = "Allow"
    actions   = [
      "events:PutTargets",
      "events:PutRule",
      "events:DescribeRule"
    ]
    resources = [
      "arn:aws:events:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:rule/${var.step_func_dbt_ecs_task_rule_name}"
    ]
  }
}

data "aws_iam_policy_document" "dbt_ecs_stepfunctions_001_sns" {
  statement {
    sid       = "SNSPublish"
    effect    = "Allow"
    actions   = [
      "sns:Publish"
    ]
    resources = [
      "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.dbt_ecs_tutorial_sns_topic_name}"
    ]
  }
}

data "aws_iam_policy_document" "dbt_ecs_stepfunctions_001_xray" {
  statement {
    sid       = "XrayAccess"
    effect    = "Allow"
    actions   = [
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
      "xray:GetSamplingRules",
      "xray:GetSamplingTargets"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "dbt_ecs_stepfunctions_001_passrole" {
  statement {
    sid       = "PassRole"
    effect    = "Allow"
    actions   = [
      "iam:PassRole"
    ]
    resources = [
      "${aws_iam_role.dbt_ecs_task_001.arn}" # TODO ロールのARNを入れる
    ]
  }
}

resource "aws_iam_policy" "dbt_ecs_stepfunctions_001_ecs" {
  name        = var.iam_policy_name_dbt_ecs_stepfunctions_001_ecs
  path        = var.iam_policy_path_dbt_ecs_stepfunctions_001_ecs
  description = "dbt step functions policy (ECS)"

  policy = data.aws_iam_policy_document.dbt_ecs_stepfunctions_001_ecs.json
}

resource "aws_iam_policy" "dbt_ecs_stepfunctions_001_sns" {
  name        = var.iam_policy_name_dbt_ecs_stepfunctions_001_sns
  path        = var.iam_policy_path_dbt_ecs_stepfunctions_001_sns
  description = "dbt step functions policy (SNS)"

  policy = data.aws_iam_policy_document.dbt_ecs_stepfunctions_001_sns.json
}

resource "aws_iam_policy" "dbt_ecs_stepfunctions_001_xray" {
  name        = var.iam_policy_name_dbt_ecs_stepfunctions_001_xray
  path        = var.iam_policy_path_dbt_ecs_stepfunctions_001_xray
  description = "dbt step functions policy (Xray)"

  policy = data.aws_iam_policy_document.dbt_ecs_stepfunctions_001_xray.json
}

resource "aws_iam_policy" "dbt_ecs_stepfunctions_001_passrole" {
  name        = var.iam_policy_name_dbt_ecs_stepfunctions_001_passrole
  path        = var.iam_policy_path_dbt_ecs_stepfunctions_001_passrole
  description = "dbt step functions policy (PassRole)"

  policy = data.aws_iam_policy_document.dbt_ecs_stepfunctions_001_passrole.json
}

#-------------------------------------
# dbt_ecs_codebuild_001
# Attach to CodeBuild
data "aws_iam_policy_document" "dbt_ecs_codebuild_001" {
  statement {
    sid       = "CodeBuildAccessToECR"
    effect    = "Allow"
    actions   = [
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid       = "CloudWatchLogs"
    effect    = "Allow"
    actions   = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/*"
    ]
  }
  statement {
    sid       = "S3"
    effect    = "Allow"
    actions   = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]
    resources = [
      "arn:aws:s3:::codepipeline-${data.aws_region.current.name}-*"
    ]
  }
  statement {
    sid       = "CodeCommit"
    effect    = "Allow"
    actions   = [
      "codecommit:GitPull"
    ]
    resources = [
      "arn:aws:codecommit:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
    ]
  }
  statement {
    sid       = "CodeBuild"
    effect    = "Allow"
    actions   = [
      "codebuild:CreateReportGroup",
      "codebuild:CreateReport",
      "codebuild:UpdateReport",
      "codebuild:BatchPutTestCases",
      "codebuild:BatchPutCodeCoverages"
    ]
    resources = [
      "arn:aws:codebuild:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:report-group/*"
    ]
  }
}

resource "aws_iam_policy" "dbt_ecs_codebuild_001" {
  name        = var.iam_policy_name_dbt_ecs_codebuild_001
  path        = var.iam_policy_path_dbt_ecs_codebuild_001
  description = "dbt CodeBuild policy"

  policy = data.aws_iam_policy_document.dbt_ecs_codebuild_001.json
}

#-------------------------------------
# dbt_ecs_codepipeline_001
# Attach to CodePipeline
data "aws_iam_policy_document" "dbt_ecs_codepipeline_001" {
  statement {
    sid       = "PassRole"
    effect    = "Allow"
    actions   = [
      "iam:PassRole"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = [
        "cloudformation.amazonaws.com",
        "elasticbeanstalk.amazonaws.com",
        "ec2.amazonaws.com",
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
  statement {
    sid       = "CodeCommit"
    effect    = "Allow"
    actions   = [
      "codecommit:CancelUploadArchive",
      "codecommit:GetBranch",
      "codecommit:GetCommit",
      "codecommit:GetRepository",
      "codecommit:GetUploadArchiveStatus",
      "codecommit:UploadArchive"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid       = "CodeDeploy"
    effect    = "Allow"
    actions   = [
      "codedeploy:CreateDeployment",
      "codedeploy:GetApplication",
      "codedeploy:GetApplicationRevision",
      "codedeploy:GetDeployment",
      "codedeploy:GetDeploymentConfig",
      "codedeploy:RegisterApplicationRevision"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid       = "resources"
    effect    = "Allow"
    actions   = [
      "elasticbeanstalk:*",
      "ec2:*",
      "elasticloadbalancing:*",
      "autoscaling:*",
      "cloudwatch:*",
      "s3:*",
      "sns:*",
      "cloudformation:*",
      "rds:*",
      "sqs:*",
      "ecs:*"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid       = "lambda"
    effect    = "Allow"
    actions   = [
      "lambda:InvokeFunction",
      "lambda:ListFunctions"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid       = "codebuild"
    effect    = "Allow"
    actions   = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
      "codebuild:BatchGetBuildBatches",
      "codebuild:StartBuildBatch"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid       = "ecr"
    effect    = "Allow"
    actions   = [
      "ecr:DescribeImages"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid       = "states"
    effect    = "Allow"
    actions   = [
      "states:DescribeExecution",
      "states:DescribeStateMachine",
      "states:StartExecution"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "dbt_ecs_codepipeline_001" {
  name        = var.iam_policy_name_dbt_ecs_codepipeline_001
  path        = var.iam_policy_path_dbt_ecs_codepipeline_001
  description = "dbt CodePipeline policy"

  policy = data.aws_iam_policy_document.dbt_ecs_codepipeline_001.json
}


#-------------------------------------
# dbt_ecs_eventbrige_001
# Attach to CloudWatch Events (EventBridge) Role

data "aws_iam_policy_document" "dbt_ecs_eventbridge_codepipeline_001" {
  statement {
    sid       = "CodePipelineExec"
    effect    = "Allow"
    actions   = [
      "codepipeline:StartPipelineExecution"
    ]
    resources = [
      "${var.dbt_codepipeline_arn}"
    ]
  }
}

resource "aws_iam_policy" "dbt_ecs_eventbridge_codepipeline_001" {
  name        = var.iam_policy_name_dbt_ecs_eventbridge_codepipeline_001
  path        = var.iam_policy_path_dbt_ecs_eventbridge_codepipeline_001
  description = "dbt eventbridge for CodePipeline policy"

  policy = data.aws_iam_policy_document.dbt_ecs_eventbridge_codepipeline_001.json
}


#-------------------------------------
# IAM Role
#-------------------------------------

#-------------------------------------
# dbt_ecs_task_001
data "aws_iam_policy_document" "dbt_ecs_task_001_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "dbt_ecs_task_001" {
  name = var.iam_role_name_dbt_ecs_task_001
  path = var.iam_role_path_dbt_ecs_task_001
  assume_role_policy = data.aws_iam_policy_document.dbt_ecs_task_001_assume_role_policy.json
  managed_policy_arns = [
    aws_iam_policy.dbt_ecs_task_001.arn
  ]
}

#-------------------------------------
# dbt_ecs_task_exec_001
data "aws_iam_policy_document" "dbt_ecs_task_exec_001_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "dbt_ecs_task_exec_001" {
  name = var.iam_role_name_dbt_ecs_task_exec_001
  path = var.iam_role_path_dbt_ecs_task_exec_001
  assume_role_policy = data.aws_iam_policy_document.dbt_ecs_task_exec_001_assume_role_policy.json
  managed_policy_arns = [
    aws_iam_policy.dbt_ecs_task_exec_001.arn
  ]
}

#-------------------------------------
# dbt_ecs_stepfunctions_001
data "aws_iam_policy_document" "dbt_ecs_stepfunctions_001_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "dbt_ecs_stepfunctions_001" {
  name = var.iam_role_name_dbt_ecs_stepfunctions_001
  path = var.iam_role_path_dbt_ecs_stepfunctions_001
  assume_role_policy = data.aws_iam_policy_document.dbt_ecs_stepfunctions_001_assume_role_policy.json
  managed_policy_arns = [
    aws_iam_policy.dbt_ecs_stepfunctions_001_ecs.arn,
    aws_iam_policy.dbt_ecs_stepfunctions_001_sns.arn,
    aws_iam_policy.dbt_ecs_stepfunctions_001_xray.arn,
    aws_iam_policy.dbt_ecs_stepfunctions_001_passrole.arn
  ]
}

#-------------------------------------
# dbt_ecs_codebuild_001
data "aws_iam_policy_document" "dbt_ecs_codebuild_001_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "dbt_ecs_codebuild_001" {
  name = var.iam_role_name_dbt_ecs_codebuild_001
  path = var.iam_role_path_dbt_ecs_codebuild_001
  assume_role_policy = data.aws_iam_policy_document.dbt_ecs_codebuild_001_assume_role_policy.json
  managed_policy_arns = [
    aws_iam_policy.dbt_ecs_codebuild_001.arn
  ]
}

#-------------------------------------
# dbt_ecs_codepipeline_001
data "aws_iam_policy_document" "dbt_ecs_codepipeline_001_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "dbt_ecs_codepipeline_001" {
  name = var.iam_role_name_dbt_ecs_codepipeline_001
  path = var.iam_role_path_dbt_ecs_codepipeline_001
  assume_role_policy = data.aws_iam_policy_document.dbt_ecs_codepipeline_001_assume_role_policy.json
  managed_policy_arns = [
    aws_iam_policy.dbt_ecs_codepipeline_001.arn
  ]
}

#-------------------------------------
# dbt_ecs_eventbrige_001
data "aws_iam_policy_document" "dbt_ecs_eventbridge_codepipeline_001_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "dbt_ecs_eventbridge_codepipeline_001" {
  name = var.iam_role_name_dbt_ecs_eventbridge_codepipeline_001
  path = var.iam_role_path_dbt_ecs_eventbridge_codepipeline_001
  assume_role_policy = data.aws_iam_policy_document.dbt_ecs_eventbridge_codepipeline_001_assume_role_policy.json
  managed_policy_arns = [
    aws_iam_policy.dbt_ecs_eventbridge_codepipeline_001.arn
  ]
}
