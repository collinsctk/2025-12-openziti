variable "CLOUDFLARE_API_TOKEN" {
  description = "The API token for Cloudflare"
  type        = string
}

variable "AWS_DEFAULT_REGION" {
  type    = string
  default = "us-east-1"
}

variable "AWS_ACCESS_KEY_ID" {
  type    = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  type    = string
}

variable "aws_region_key" {
  type    = string
  default = "us-east-1-2023"
}

variable "cloudflare_zone_id" {
  type    = string
}