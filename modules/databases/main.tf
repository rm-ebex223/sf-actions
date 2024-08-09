##########
# DATABASE: Create the database
resource "snowflake_database" "DATABASE" {
  name                        = var.database_name
  comment                     = var.database_comment
  data_retention_time_in_days = var.database_data_retention_days
}

# DATABASE: If the database grant map is empty, skip it. Else loop through and grant role/privilege combo
resource "snowflake_grant_privileges_to_account_role" "DB_GRANT" { 
  for_each          = { for role, priv in var.database_grants : role => priv if var.database_grants != {} }
  account_role_name = each.key
  always_apply      = var.db_always_apply
  privileges        = each.value
  with_grant_option = var.db_with_grant_option
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.DATABASE.name
  }
}

##########
# SCHEMA: If the schema object is empty, skip it. Else loop through and create the schemas
resource "snowflake_schema" "SCHEMA" {
  for_each            = { for schema in var.schema_info : schema.schema_name => schema if schema != [] }
  database            = snowflake_database.DATABASE.name
  name                = each.key
  comment             = each.value.schema_comment
  is_transient        = each.value.schema_is_transient
  is_managed          = each.value.schema_is_managed
  data_retention_days = each.value.schema_data_retention_days
}

# SCHEMA: If the schema object is empty, skip it. Else loop through and create the RBAC database roles 
module "CREATE_BASE_DB_ROLES" {
  for_each      = { for schema in var.schema_info : schema.schema_name => schema if schema != [] }
  source        = "./../base_rbac_db_roles"
  database_name = snowflake_database.DATABASE.name
  schema_name   = each.key
  add_liquibase = var.add_liquibase
  depends_on    = [snowflake_schema.SCHEMA] 
}

##########
# LIQUIBASE: If add_liquibase is true, create the LIQUIBASE management schema 
resource "snowflake_schema" "LIQUIBASE_SCHEMA" {
  count               = var.add_liquibase ? 1 : 0
  database            = snowflake_database.DATABASE.name
  name                = var.liquibase_schema_name
  comment             = "Schema for managing Liquibase. Only the db deploy user has RW"
  is_transient        = false
  is_managed          = true
  data_retention_days = 7
}

# LIQUIBASE: If add_liquibase is true, create the RBAC database roles and grant ELEV to db deployer user
module "CREATE_LIQUIBASE_DB_ROLES" { 
  count         = var.add_liquibase ? 1 : 0
  source        = "./../base_rbac_db_roles"
  database_name = snowflake_database.DATABASE.name
  schema_name   = var.liquibase_schema_name
  add_liquibase = var.add_liquibase 
  depends_on    = [snowflake_schema.LIQUIBASE_SCHEMA] 
} 