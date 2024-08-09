variable "database_name" {
  type = string
}

variable "database_comment" {
  type    = string
  default = ""
}

variable "database_data_retention_days" {
  type    = number
  default = 1
}

variable "schema_info" {
  type = list(object({
    schema_name                = string,
    schema_comment             = optional(string, ""),
    schema_is_transient        = optional(string, false),
    schema_is_managed          = optional(string, false),
    schema_data_retention_days = optional(number, 1)
  }))
  default = []
}

variable "role_comment" {
  type    = string
  default = ""
}

variable "db_with_grant_option" {
  type    = bool
  default = false
}

variable "database_grants" {
  type    = map(any)
  #default = { ACCOUNTADMIN = ["USAGE"] }
  default = {}
}

variable "db_always_apply" {
  type    = bool
  default = false
}

variable "add_liquibase" {
  type        = bool  
  default     = true
  description = "Tells whether or not to add a Liquibase schema and privileges to the database"
}

variable "liquibase_schema_name" {
  type     = string
  default = "LIQUIBASE"
}