terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.93.0"
    }
  }

  backend "remote" {
    organization = "sf-terraform-actions"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

provider "snowflake" {
  role     = "TERRAFORM_DEPLOY"
}

resource "snowflake_database" "demo_db" {
  name    = "DEMO_DB"
  comment = "Database for Snowflake Terraform demo"
}