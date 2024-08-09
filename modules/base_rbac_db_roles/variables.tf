variable "database_name" {
  type = string
}

variable "schema_name" {
  type = string
}

variable "role_comment" {
  type    = string
  default = ""
}

variable "with_grant_option" {
  type    = bool
  default = false
}

variable "add_liquibase" {
  type    = bool 
}

# List of available privileges: https://docs.snowflake.com/en/user-guide/security-access-control-privileges
variable "ro_future_grants" {
  type = map(any)
  default = {
    "TABLES"    = ["SELECT"],
    "VIEWS"     = ["SELECT"],
    "SEQUENCES" = ["USAGE"]
  }
}

variable "ro_schema_grants" {
  type = list(string)
  default = ["USAGE"]
}

variable "rw_future_grants" {
  type = map(any)
  default = {
    "TABLES"    = ["SELECT", "INSERT", "UPDATE", "DELETE","TRUNCATE"],
    "VIEWS"     = ["SELECT"],
    "SEQUENCES" = ["USAGE"]
  }
}

variable "rw_schema_grants" {
  type = list(string)
  default = ["USAGE"]
}

variable "elev_future_grants" {
  type = map(any)
  default = {
    "TABLES"    = ["ALL"],
    "VIEWS"     = ["ALL"],
    "SEQUENCES" = ["ALL"]
  }
} 

variable "elev_schema_grants" {
  type = list(string)
  default = ["USAGE",
             "CREATE TABLE",
             "CREATE VIEW",
             "CREATE SEQUENCE",
             "CREATE FUNCTION",
             "CREATE PROCEDURE"]
}

variable "exec_future_grants" {
  type = map(any)
  default = {
    "FUNCTIONS"  = ["USAGE"],
    "PROCEDURES" = ["USAGE"]
  }
}

variable "exec_schema_grants" {
  type = list(string)
  default = ["USAGE"]
}

variable "db_role_parent" {
  type    = string
  default = "LIQUIBASE_DEPLOY"
}