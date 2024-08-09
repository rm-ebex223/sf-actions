variable "wh_always_apply" {
  type    = bool
  default = false
}

variable "wh_auto_suspend" {
    type = number
    default = 120
}

variable "wh_auto_resume" {
    type = bool
    default = true
}

variable "wh_comment" {
    type = string
    default = ""
}

variable "wh_grants" {
  type    = map(any)
  #default = { ACCOUNTADMIN = ["USAGE"] }
  default = {}
}

variable "wh_name" {
    type = string
} 

variable "wh_size" {
    type = string
    default = "XSMALL"
}

variable "wh_type" {
    type = string
    default = "STANDARD"
}

variable "wh_with_grant_option" {
    type = bool
    default = false
}