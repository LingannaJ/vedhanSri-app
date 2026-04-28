terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket         = "vedhansri-terraform-state" # మీ బకెట్ పేరు మార్చుకోండి
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true            # LockID అనే Partition Key తో టేబుల్ ఉండాలి
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}