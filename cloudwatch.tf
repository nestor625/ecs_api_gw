resource "aws_cloudwatch_event_rule" "console" {
  name        = "${var.project_name}-${var.tag_env}-ECS"
  description = "ECS Task State Change"

  event_pattern = <<EOF
{
   "source":[
      "aws.ecs"
   ],
   "detail-type":[
      "ECS Task State Change"
   ],
   "detail":{
      "lastStatus":[
         "STOPPED"
      ],
      "stoppedReason":[
         "Essential container in task exited"
      ]
   }
}
EOF
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.console.name
  target_id = "ECS"
  arn       = aws_sns_topic.sns_topic.arn
}