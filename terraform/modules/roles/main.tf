resource "snowflake_role" "ROLE" {
  name    = var.role_name
  comment = var.role_comment
}

# Check if there are roles or users to grant to. If both are null, skip resource
resource "snowflake_role_grants" "GRANT_ROLE" {
  count = var.grant_to_roles != null || var.grant_to_users != null ? 1 : 0
  role_name = snowflake_role.ROLE.name
  roles     = var.grant_to_roles
  users     = var.grant_to_users
}

resource "snowflake_grant_database_role" "GRANT_DB_ROLE_TO_ROLE" {
  for_each = toset([ for db_role in var.db_roles_to_grant : db_role if db_role != [] ])
  database_role_name = each.key
  parent_role_name   = snowflake_role.ROLE.name
}