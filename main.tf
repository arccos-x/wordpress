module "ha-wordpress" {
    source = "./modules"
    
    aws_profile           = var.aws_profile
    prefix                = "wordpress"
    site_domain           = var.site_domain

    desired_count         = "1"
    log_retention_in_days = "1"

    vpc_cidr              = "10.0.0.0/16"
    public_subnet_cidrs   = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
    private_subnet_cidrs  = ["10.0.100.0/24", "10.0.101.0/24", "10.0.102.0/24"]

    db_backup_retention_days = "1"
    db_backup_window         = "01:00-02:00"
    db_max_capacity          = "1"
    db_min_capacity          = "1"
    db_master_username       = var.db_master_username
    db_master_password       = var.db_master_password
}

