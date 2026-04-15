output "ecs_cpu_alarm_name" {
  value = aws_cloudwatch_metric_alarm.ecs_cpu_high.alarm_name
}

output "ecs_memory_alarm_name" {
  value = aws_cloudwatch_metric_alarm.ecs_memory_high.alarm_name
}

output "alb_5xx_alarm_name" {
  value = aws_cloudwatch_metric_alarm.alb_5xx_high.alarm_name
}

output "target_unhealthy_alarm_name" {
  value = aws_cloudwatch_metric_alarm.target_unhealthy_hosts.alarm_name
}