terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket         = "vedhansri-terraform-state"
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    # Helm మరియు Kubernetes ప్రొవైడర్లను ఇక్కడ యాడ్ చేస్తున్నాం
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.27.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Helm కి కావాల్సిన మెయిన్ కుబెర్నెటిస్ కాన్ఫిగరేషన్ ఇక్కడ ఇస్తున్నాం
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}