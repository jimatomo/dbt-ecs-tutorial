#-------------------------------------
# EventBridge
#-------------------------------------

data "template_file" "event_pattern_codepipeline" {
  template = "${file("${path.module}/event_pattern_codepipeline.json")}"
  vars = {
    resources_var = "${aws_codecommit_repository.dbt_ecs_tutorial_codecommit_repos.arn}"
  }
}

resource "aws_cloudwatch_event_rule" "events_rule_codepipeline" {
  name        = var.events_rule_codepipeline_name
  description = "CodePipeline CloudWatch Events"

  event_pattern = "${data.template_file.event_pattern_codepipeline.rendered}"
}

resource "aws_cloudwatch_event_target" "events_target_codepipeline" {
  target_id = var.events_target_id_codepipeline
  rule      = aws_cloudwatch_event_rule.events_rule_codepipeline.name
  arn       = aws_codepipeline.dbt_ecs_tutorial_codepipeline.arn
  role_arn  = var.dbt_ecs_eventbridge_codepipeline_001_role_arn
}
