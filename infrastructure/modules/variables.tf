variable "aws_profile" {}

variable "tags" {
  default     = {}
}

variable "prefix" {
  description = "Prefix for all the resources to be created"
}

variable "site_domain" {
  description = "The primary domain name of the website"
}

variable "cf_price_class" {
  description = "The price class for this distribution"
  default     = "PriceClass_100"
}

variable "error_ttl" {
  description = "The minimum amount of time (in secs) that cloudfront caches an HTTP error code."
  default     = "30"
}

variable "desired_count" {
  description = "The number of instances of fargate tasks to keep running"
}

variable "log_retention_in_days" {
  description = "The number of days to retain cloudwatch log"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
}

variable "environment" {
  description = "Name of the application environment"
  default     = "dev"
}

variable "db_backup_retention_days" {
  description = "Number of days to retain db backups"
}

variable "db_backup_window" {
  description = "The daily time range during which automated backups for rds are created"
}

variable "db_max_capacity" {
  description = "The maximum Aurora capacity unit of the db"
}

variable "db_min_capacity" {
  description = "The minimum Aurora capacity unit of the db"
}

variable "db_master_username" {
  description = "Master username of the db"
}

variable "db_master_password" {
  description = "Master password of the db"
}

variable "db_engine_version" {
  description = "The database engine version"
  default     = "5.6.10a"
}

variable "db_auto_pause" {
  description = "Whether to enable auto pause"
  default     = true
}

variable "db_seconds_until_auto_pause" {
  description = "The time in seconds before Aurora DB is paused"
  default     = 300
}

variable "task_memory" {
  description = "The amount (in MiB) of memory used by the task"
  default     = 2048
}

variable "task_cpu" {
  description = "The number of cpu units used by the task"
  default     = 1024
}

variable "scaling_up_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start (upscaling)"
  default     = "60"
}

variable "scaling_down_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start (downscaling)"
  default     = "300"
}

variable "scaling_up_adjustment" {
  description = " The number of tasks by which to scale, when the upscaling parameters are breached"
  default     = "1"
}

variable "scaling_down_adjustment" {
  description = " The number of tasks by which to scale (negative for downscaling), when the downscaling parameters are breached"
  default     = "-1"
}

variable "task_cpu_low_threshold" {
  description = "The CPU value below which downscaling kicks in"
  default     = "30"
}

variable "task_cpu_high_threshold" {
  description = "The CPU value above which downscaling kicks in"
  default     = "75"
}

variable "max_task" {
  description = "Maximum number of tasks should the service scale to"
  default     = "2"
}

variable "min_task" {
  description = "Minimum number of tasks should the service always maintain"
  default     = "1"
}

