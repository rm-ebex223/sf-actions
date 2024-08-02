terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.93.0"
    }
  }
}


provider "snowflake" {
  account  = var.snowflake_account
  user     = var.snowflake_username
  password = var.snowflake_password
  role     = "PUBLIC"
}

# Use this role to:
#   - Create anything at the account level + anything above a schema level
#   - Make changes to anything at the account level + anything above a schema level
provider "snowflake" {
  alias    = "deployuser_tf_deploy"
  account  = var.snowflake_account
  user     = var.snowflake_username
  password = var.snowflake_password
  role     = "TERRAFORM_DEPLOY"
}

# Use this role to:
#   - Create non-schema objects within a database (tables, views, functions, etc)
#   - Make changes to non-schema objects within a database (tables, views, functions, etc)
provider "snowflake" {
  alias    = "deployuser_db_deploy"
  account  = var.snowflake_account
  user     = var.snowflake_username
  password = var.snowflake_password
  role     = "LIQUIBASE_DEPLOY"
}

# Use this role to:
#   - Create users and roles
#   - Manages role grants and user privileges
provider "snowflake" {
  alias    = "deployuser_securityadmin"
  account  = var.snowflake_account
  user     = var.snowflake_username
  password = var.snowflake_password
  role     = "SECURITYADMIN"
}