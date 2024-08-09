resource "snowflake_user" "USER" {
  name                    = var.user_name
  comment                 = var.user_comment
  disabled                = var.user_disabled
  default_warehouse       = var.user_default_warehouse 
  default_role            = var.user_default_role
  # rsa_public_key        = var.user_rsa_public_key
  must_change_password    = var.user_must_change_pwd
} 

resource "snowflake_role_grants" "GRANT_DEFAULT_USER_ROLE" {
  role_name = snowflake_user.USER.default_role
  users     = [ snowflake_user.USER.name ]
}