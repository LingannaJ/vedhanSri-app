module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "vedhansri-vpc"
  cidr = "10.0.0.0/16"

  # ముంబై జోన్లు తీసేసి ఖచ్చితంగా వర్జీనియా జోన్లు ఇచ్చాం
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  # RDS కోసం ఈ డేటాబేస్ సబ్‌నెట్స్ అదనంగా యాడ్ చేయాలి
  database_subnets             = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]
  create_database_subnet_group = true

  enable_nat_gateway = true
  single_nat_gateway = true # ఖర్చు తగ్గించడానికి

  public_subnet_tags = {
    "kubernetes.io/role/elb"              = "1"
    "kubernetes.io/cluster/vedhansri-eks" = "shared" # క్లస్టర్ నేమ్ ఇక్కడ ఉండాలి
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"     = "1"
    "kubernetes.io/cluster/vedhansri-eks" = "shared"
  }
}