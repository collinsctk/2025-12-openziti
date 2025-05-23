terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "cloudflare" {
  alias       = "cloudflare"
  api_token   = var.CLOUDFLARE_API_TOKEN
}

provider "aws" {
  alias       = "aws_provider"
  region      = var.aws_region
  access_key  = var.AWS_ACCESS_KEY_ID
  secret_key  = var.AWS_SECRET_ACCESS_KEY
}