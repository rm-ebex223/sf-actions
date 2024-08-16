resource "snowflake_warehouse" "WAREHOUSE" {
  auto_resume    = var.wh_auto_resume
  auto_suspend   = var.wh_auto_suspend
  comment        = var.wh_comment
  name           = var.wh_name
  warehouse_size = var.wh_size
  warehouse_type = var.wh_type
} 

# If the warehouse grant map isn't empty, run the resource. Else skip it.
resource "snowflake_grant_privileges_to_account_role" "DB_GRANT" { 
  for_each          = { for role, priv in var.wh_grants : role => priv if var.wh_grants != {} }
  account_role_name = each.key
  always_apply      = var.wh_always_apply
  privileges        = each.value
  with_grant_option = var.wh_with_grant_option
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.WAREHOUSE.name
  }
}