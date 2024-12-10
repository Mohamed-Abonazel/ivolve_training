# sns.tf

resource "aws_sns_topic" "main" {
  name = "high_cpu_topic"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.main.arn
  protocol  = "email"
  endpoint  = var.sns_email  # Replace with your email address
}



