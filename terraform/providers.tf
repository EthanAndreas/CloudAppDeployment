terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.3"
    }
  }
}

variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}

variable "account_id" {
  default = "4f82d842615ee6cdbfb633767c5e6aa3"
}

variable "domain" {
  default = "100do.se"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

data "cloudflare_zone" "zone" {
  account_id = var.account_id
  name       = var.domain
}
