terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.93.0"
    }
  }

  cloud {
    organization = "sf-terraform-actions"

    workspaces {
      project = "sf-tf-actions"
      tags    = ["main"]
    }
  }
}