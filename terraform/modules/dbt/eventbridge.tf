#-------------------------------------
# EventBridge
#-------------------------------------

resource "aws_cloudwatch_event_rule" "events_rule_codepipeline" {
  name        = var.events_rule_codepipeline_name
  description = "CodePipeline CloudWatch Events"

  event_pattern = <<EOF
{
  "source": [
    "aws.codecommit"
  ],
  "detail-type": [
    "CodeCommit Repository State Change"
  ],
  "resources": [
    {
      ${aws_codecommit_repository.dbt_ecs_tutorial_codecommit_repos.arn}
    }
  ],
  "detail": {
    "event": [
      "referenceCreated",
      "referenceUpdated"
    ],
    "referenceType": [
      "branch"
    ],
    "referenceName": [
      "main"
    ]
  }
}
EOF
}

resource "aws_cloudwatch_event_target" "events_target_codepipeline" {
  target_id = var.events_target_id_codepipeline
  rule      = aws_cloudwatch_event_rule.events_rule_codepipeline.name
  arn       = aws_codepipeline.dbt_ecs_tutorial_codepipeline.arn
  role_arn  = var.dbt_ecs_eventbridge_codepipeline_001_role_arn
}
