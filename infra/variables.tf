variable "aws-access-key" {
  type = string
}

variable "aws-secret-key" {
  type = string
}

variable "name" {
  description = "the name of the stack"
}

variable "environment" {
  description = "the name of the environment"
}

variable "aws_region" {
  type        = string
  description = "The AWS region things are created in"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
}

variable "app_name" {
  description = "Application to run in the ECS cluster"
}

variable "health_check_path" {
  description = "Http path for task health check"
}

variable "min_capacity" {
  description = "Auto Scaling min_capacity"
}

variable "max_capacity" {
  description = "Auto Scaling max_capacity"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
}

variable "app_count" {
  description = "Number of docker containers to run"
}

variable "allocated_storage" {
  description = "The storage size in GB"
}

variable "database_name" {
  description = "The database name"
}

variable "database_username" {
  description = "The username of the database"
}

variable "database_password" {
  description = "The password of the database"
}