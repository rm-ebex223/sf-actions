
# resource "snowflake_database" "demo_db" {
#   name    = "DB_DB"
#   comment = "Database for Snowflake Terraform demo"
# }

# resource "snowflake_schema" "demo_schema" {
#   database = snowflake_database.demo_db.name
#   name     = "DEMO_SCHEMA"
#   comment  = "Schema for Snowflake Terraform demo"
# }

# resource "snowflake_database" "demo_db_2" {
#   name    = "ANOTHER_DEMO_DB"
#   comment = "Database for Snowflake Terraform demo"
# }

# resource "snowflake_database" "demo_db_3" {
#   name    = "MORE_DEMO_DB"
#   comment = "Database for Snowflake Terraform demo"
# }

# resource "snowflake_database" "boop" {
#   name    = "BOOP"
#   comment = "Database for Snowflake Terraform demo"
# }