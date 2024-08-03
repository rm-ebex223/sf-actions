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
  name    = "DEMO_DB"
  comment = "Database for Snowflake Terraform demo"
}

resource "snowflake_schema" "demo_schema" {
  database = snowflake_database.demo_db.name
  name     = "DEMO_SCHEMA"
  comment  = "Schema for Snowflake Terraform demo"
}

# resource "snowflake_database" "demo_db_2" {
#   name    = "ANOTHER_DEMO_DB"
#   comment = "Database for Snowflake Terraform demo"
# }

# resource "snowflake_schema" "more_demo_schema" {
#   database = snowflake_database.demo_db_2.name
#   name     = "MORE_DEMO_SCHEMA"
#   comment  = "Schema for Snowflake Terraform demo"
# }