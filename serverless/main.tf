resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = "in-tax-dem-dev-aurora"
  engine                  = "aurora-postgresql"
  engine_version        = "14.6"
  engine_mode        = "provisioned"
  #instance_class     = "db.r6i.large"
  db_subnet_group_name = aws_db_subnet_group.default.id
  availability_zones      = ["ap-south-1a","ap-south-1b"]
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  backup_retention_period = 7
  preferred_backup_window = "02:00-04:00"
  network_type = "IPV4"
  port = 5432
  vpc_security_group_ids =["sg-0d341eabfb69b6cc8"]
  skip_final_snapshot = "false"
  final_snapshot_identifier =  local.snapshot_date
  snapshot_identifier = "${data.aws_db_cluster_snapshot.cluster_snapshot.id}"
  enabled_cloudwatch_logs_exports = ["postgresql"]
  allow_major_version_upgrade = "true"
  enable_http_endpoint = "true"
  serverlessv2_scaling_configuration {
    max_capacity = var.max_capacity
    min_capacity = var.min_capacity
  }


   tags = {
    Name = "aurora_postgres"
  }
}



resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  engine             = aws_rds_cluster.postgresql.engine   #var.engine
  engine_version     = aws_rds_cluster.postgresql.engine_version  #var.engine_version
  cluster_identifier = aws_rds_cluster.postgresql.id
  instance_class     = "db.serverless"
  db_subnet_group_name = aws_db_subnet_group.default.id
  monitoring_interval = 60
  monitoring_role_arn= aws_iam_role.aurora_monitoring_role.arn
  performance_insights_enabled = true
  performance_insights_retention_period = 7

}

resource "aws_db_subnet_group" "default" {
  name       = "db-subn"
  subnet_ids = ["subnet-0b40d54adbf790d77","subnet-09af2cf4af7020583"]

  tags = {
    Name = "My DB subnet group"
  }
}


output "database_name"{
   value= var.database_name
}

output "master_username"{
   value= var.master_username
}
#output "aurora_cluster_endpoint" {
   #value = aws_rds_cluster_instance.cluster_instances[0].endpoint

#}

output "aurora_cluster_endpoint" {
   value = aws_rds_cluster.postgresql.endpoint

}

output "master_password"{
   value= var.master_password
}


data "aws_db_cluster_snapshot" "cluster_snapshot" {
  db_cluster_identifier = "in-tax-dem-dev-aurora"
  snapshot_type        = "manual"
  most_recent          = true
}
locals {
  snapshot_date =  join("", ["in-tax-dem-dev-aurora", formatdate("YYYYMMDDhhmm", timestamp())])

}
output "timestamp" {
  value = "${local.snapshot_date}"
}

