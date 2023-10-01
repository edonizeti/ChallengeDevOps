resource "aws_mq_broker" "rabbitmq" {
  for_each = { for instances in try(local.workspace.rabbitmq.instances, []) : instances.name => instances }
  broker_name = each.value.roker_name
  engine_type = each.value.engine_type
  engine_version = each.value.engine_version 
  host_instance_type = each.value.host_instance_type 
  storage_type = each.value.storage_type
  security_groups = [aws_security_group.rabbitmq.id]
  auto_minor_version_upgrade = true
  deployment_mode = each.value.deployment_mode 
  publicly_accessible = each.value.publicly_accessible
  maintenance_window_start_time {
    day_of_week = each.value.day_of_week 
    time_of_day = each.value.time_of_day 
    time_zone = each.value.time_zone 
  }
  subnet_ids = [aws_subnet.PrivateSubnet1.id]
  user {
    username = aws_ssm_parameter.username[each.value].value
    password = aws_ssm_parameter.password[each.value].value
  }
}

resource "aws_ssm_parameter" "username" {
  for_each = { for instances in try(local.workspace.rabbitmq.instances, []) : instances.name => instances }
  name  = "/rabbitmq/${local.environment_name}/username"
  type  = "SecureString"
  tier  = "Advanced"
  value = "NO_VALUE"

    lifecycle {
    ignore_changes = [value]
  }
}

  resource "aws_ssm_parameter" "password" {
  for_each = { for instances in try(local.workspace.rabbitmq.instances, []) : instances.name => instances }
  name  = "/rabbitmq/${local.environment_name}/password"
  type  = "SecureString"
  tier  = "Advanced"
  value = "NO_VALUE"

    lifecycle {
    ignore_changes = [value]
  }
}