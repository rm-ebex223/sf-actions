module "LIQUIBASE_TEST" {
  source        = "./modules/databases"
  database_name = "LIQUIBASE_TEST"
  # database_grants = {
  #   #SYSADMIN = ["USAGE"]
  # }
   schema_info = [ 
     { schema_name = "TEST_STUFF" }
  #   { schema_name = "MORE_TEST" }
  ] 
  #add_liquibase = false
}


# module "LIQUIBASE_WH" {
#   source = "./modules/warehouses"
#   wh_name = "LIQUIBASE_WH"  
#   wh_grants = {
#     SYSADMIN = ["USAGE","OPERATE"] ,
#     LIQUIBASE_DEPLOY = ["USAGE","OPERATE"]
#   }
# }
