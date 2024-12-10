# cloudwatch.tf

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high_cpu_alarm"
  comparison_operator = "GreaterThanThreshold"
  threshold           = 80
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  dimensions = {
    InstanceId = aws_instance.my_ec2.id
  }

  alarm_actions = [aws_sns_topic.main.arn]
}

