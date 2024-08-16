variable "role_name" {
    type = string
}

variable "role_comment" {
    type = string
    default = ""
}

variable "grant_to_roles" {
    type = set(string)
    default = null
}

variable "grant_to_users" {
    type = set(string)
    default = null
}

variable "db_roles_to_grant" {
    type = set(string)
    default = []
}