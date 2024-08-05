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
}

resource "snowflake_database" "demo_db" {
  name    = "DEMOING"
  comment = "Database for Snowflake Terraform demo"
}

