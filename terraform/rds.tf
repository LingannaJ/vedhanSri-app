module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.1.1"

  identifier = "vedhansri-production-db"

  engine            = "postgres"
  engine_version    = "13"
  family            = "postgres13"
  instance_class    = "db.t3.medium"
  allocated_storage = 20

  db_name  = "catalog_db"
  username = "dbadmin"
  port     = 5432

  multi_az               = true
  db_subnet_group_name   = module.vpc.database_subnet_group
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot = true # Practice కోసం మాత్రమే
}