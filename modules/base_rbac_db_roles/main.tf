##########
# READ-ONLY: Create role
resource "snowflake_database_role" "RO_ROLE" {
  database = var.database_name
  name     = "AR_${var.schema_name}_RO"
  comment  = var.role_comment
}

# READ-ONLY: Grant future read-only privileges on schema objects
resource "snowflake_grant_privileges_to_database_role" "RO_FUTURE_GRANT" {
  for_each           = var.ro_future_grants
  privileges         = each.value
  database_role_name = "${snowflake_database_role.RO_ROLE.database}.${snowflake_database_role.RO_ROLE.name}"
  on_schema_object {
    future {
      object_type_plural = each.key
      in_schema          = "${snowflake_database_role.RO_ROLE.database}.${var.schema_name}"
    }
  }
  with_grant_option = var.with_grant_option
}

# READ-ONLY: Grant future read-only privileges on schema itself
resource "snowflake_grant_privileges_to_database_role" "RO_SCHEMA_GRANTS" { 
  privileges         = var.ro_schema_grants
  database_role_name = "${snowflake_database_role.RO_ROLE.database}.${snowflake_database_role.RO_ROLE.name}"
  on_schema {
    schema_name = "${snowflake_database_role.RO_ROLE.database}.${var.schema_name}"
  }
  with_grant_option = var.with_grant_option
}

##########
# READ-WRITE: Create read-write role
resource "snowflake_database_role" "RW_ROLE" {
  database = var.database_name
  name     = "AR_${var.schema_name}_RW"
  comment  = var.role_comment
}

# READ-WRITE: Grant future read-write privileges on schema objects
resource "snowflake_grant_privileges_to_database_role" "RW_FUTURE_GRANT" {
  for_each           = var.rw_future_grants
  privileges         = each.value
  database_role_name = "${snowflake_database_role.RW_ROLE.database}.${snowflake_database_role.RW_ROLE.name}"
  on_schema_object {
    future {
      object_type_plural = each.key
      in_schema          = "${snowflake_database_role.RW_ROLE.database}.${var.schema_name}"
    }
  }
  with_grant_option = var.with_grant_option
}

# READ-WRITE: Grant future read-write privileges on schema itself
resource "snowflake_grant_privileges_to_database_role" "RW_SCHEMA_GRANTS" { 
  privileges         = var.rw_schema_grants
  database_role_name = "${snowflake_database_role.RW_ROLE.database}.${snowflake_database_role.RW_ROLE.name}"
  on_schema {
    schema_name = "${snowflake_database_role.RW_ROLE.database}.${var.schema_name}"
  }
  with_grant_option = var.with_grant_option
}

##########
# ELEVATED: Create elevated access role
resource "snowflake_database_role" "ELEV_ROLE" {
  database = var.database_name
  name     = "AR_${var.schema_name}_ELEV"
  comment  = var.role_comment
}

# ELEVATED: Grant future elevated privileges on schema objects
resource "snowflake_grant_privileges_to_database_role" "ELEV_FUTURE_GRANT" {
  for_each           = var.elev_future_grants
  privileges         = each.value
  database_role_name = "${snowflake_database_role.ELEV_ROLE.database}.${snowflake_database_role.ELEV_ROLE.name}"
  on_schema_object {
    future {
      object_type_plural = each.key
      in_schema          = "${snowflake_database_role.ELEV_ROLE.database}.${var.schema_name}"
    }
  }
  with_grant_option = var.with_grant_option
}

# ELEVATED: Grant future elevated privileges on schema itself
resource "snowflake_grant_privileges_to_database_role" "ELEV_SCHEMA_GRANTS" { 
  privileges         = var.elev_schema_grants
  database_role_name = "${snowflake_database_role.ELEV_ROLE.database}.${snowflake_database_role.ELEV_ROLE.name}"
  on_schema {
    schema_name = "${snowflake_database_role.ELEV_ROLE.database}.${var.schema_name}"
  }
  with_grant_option = var.with_grant_option
}

##########
# EXECUTE: Create function/procedure execution role
resource "snowflake_database_role" "EXEC_ROLE" {
  database = var.database_name
  name     = "AR_${var.schema_name}_EXEC"
  comment  = var.role_comment
}

# EXECUTE: Grant future execution privileges on schema objects
resource "snowflake_grant_privileges_to_database_role" "EXEC_FUTURE_GRANT" {
  for_each           = var.exec_future_grants
  privileges         = each.value
  database_role_name = "${snowflake_database_role.EXEC_ROLE.database}.${snowflake_database_role.EXEC_ROLE.name}"
  on_schema_object {
    future {
      object_type_plural = each.key
      in_schema          = "${snowflake_database_role.EXEC_ROLE.database}.${var.schema_name}"
    }
  }
  with_grant_option = var.with_grant_option
}

# EXECUTE: Grant future execution privileges on schema itself
resource "snowflake_grant_privileges_to_database_role" "EXEC_SCHEMA_GRANTS" { 
  privileges         = var.exec_schema_grants
  database_role_name = "${snowflake_database_role.EXEC_ROLE.database}.${snowflake_database_role.EXEC_ROLE.name}"
  on_schema {
    schema_name = "${snowflake_database_role.EXEC_ROLE.database}.${var.schema_name}"
  }
  with_grant_option = var.with_grant_option
}


##########
# LIQUIBASE: If flag is true, grant elevated access role to database IaC deployment user 
resource "snowflake_grant_database_role" "GRANT_ELEV_DB_ROLE" {
  count              = var.add_liquibase ? 1 : 0
  database_role_name = "${snowflake_database_role.ELEV_ROLE.database}.${snowflake_database_role.ELEV_ROLE.name}"
  parent_role_name   = var.db_role_parent
}

# LIQUIBASE: If flag is true, grant function/procedure execute role to database IaC deployment user 
resource "snowflake_grant_database_role" "GRANT_EXEC_DB_ROLE" {
  count              = var.add_liquibase ? 1 : 0
  database_role_name = "${snowflake_database_role.EXEC_ROLE.database}.${snowflake_database_role.EXEC_ROLE.name}"
  parent_role_name   = var.db_role_parent
}