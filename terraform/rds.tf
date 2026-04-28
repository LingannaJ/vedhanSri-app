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

  # Production-ready setup
  multi_az               = true
  
  # VPC మాడ్యూల్ నుండి డేటాబేస్ సబ్‌నెట్ గ్రూప్‌ను తీసుకుంటుంది
  db_subnet_group_name   = module.vpc.database_subnet_group_name

  # సెక్యూరిటీ గ్రూప్ రిఫరెన్స్‌ను ఖచ్చితంగా ఇలా ఇవ్వాలి
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  # Delete చేసేటప్పుడు ఇబ్బంది లేకుండా (Practice కోసం)
  skip_final_snapshot = true 
  deletion_protection = false
}