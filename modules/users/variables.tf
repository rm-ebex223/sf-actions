variable "user_name" {
    type = string
}

variable "user_comment" {
    type = string
    default = ""
}

variable "user_disabled" {
    type = bool
    default = false
}

variable "user_default_warehouse" {
    type = string
}

variable "user_default_role" {
    type = string 
}

variable "user_must_change_pwd" {
    type = bool
    default = false
}

# variable "user_rsa_public_key" {
#     type = string
# }

variable "user_default_role_comment" {
    type = string
    default = ""
}