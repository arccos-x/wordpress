resource "aws_ecs_cluster" "this" {
  name = "${var.prefix}-${var.environment}"
}

resource "aws_security_group" "wordpress" {
  name        = "${var.prefix}-wordpress-${var.environment}"
  description = "Fargate wordpress"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id, aws_security_group.efs.id]
  }

  tags = var.tags
}

resource "aws_ecs_service" "this" {
  name             = "${var.prefix}-${var.environment}"
  cluster          = aws_ecs_cluster.this.id
  task_definition  = aws_ecs_task_definition.this.arn
  desired_count    = var.desired_count
  launch_type      = "FARGATE"
  platform_version = "1.4.0" // required for mounting efs
  network_configuration {
    security_groups = [aws_security_group.alb.id, aws_security_group.db.id, aws_security_group.efs.id]
    subnets         = module.vpc.private_subnets
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.id
    container_name   = "wordpress"
    container_port   = 80
  }

  lifecycle {
    ignore_changes = ["desired_count"]
  }

}


resource "aws_ecs_task_definition" "this" {
  family                   = "${var.prefix}-${var.environment}"
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  task_role_arn            = aws_iam_role.task_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  container_definitions    = <<CONTAINER_DEFINITION
[
  {
    "secrets": [
      {
        "name": "WORDPRESS_DB_USER", 
        "valueFROM": "${aws_ssm_parameter.db_master_user.arn}"
      },
      {
        "name": "WORDPRESS_DB_PASSWORD", 
        "valueFROM": "${aws_ssm_parameter.db_master_password.arn}"
      }
    ],
    "environment": [
      {
        "name": "WORDPRESS_DB_HOST",
        "value": "${aws_rds_cluster.this.endpoint}"
      },
      {
        "name": "WORDPRESS_DB_NAME",
        "value": "wordpress"
      }
    ],
    "essential": true,
    "image": "wordpress",        
    "name": "wordpress",
    "portMappings": [
      {
        "containerPort": 80
      }
    ],
    "mountPoints": [
      {
        "containerPath": "/var/www/html",
        "sourceVolume": "efs"
      }
    ],
    "logConfiguration": {
      "logDriver":"awslogs",
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.wordpress.name}",
        "awslogs-region": "${data.aws_region.current.name}",
        "awslogs-stream-prefix": "app"
      }
    }
  }
]
CONTAINER_DEFINITION

  volume {
    name = "efs"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.this.id
    }
  }
}

resource "aws_lb_target_group" "this" {
  name        = "${var.prefix}-${var.environment}"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id
  health_check {
    path    = "/"
    matcher = "200,302"
  }

}

resource "aws_lb_listener_rule" "wordpress" {
  listener_arn = module.alb.https_listener_arns[0]
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  condition {
    host_header {
      values = [var.site_domain, module.alb.this_lb_dns_name]
    }
  }
}

