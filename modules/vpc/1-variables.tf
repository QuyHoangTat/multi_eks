variable "project_name" {
  default = "project_name"
}

variable "project_env" {
  default = "project_env"
}

variable "region" {
  default = "ap-southeast-1"
}

variable "cidr" {
  type = string
  default = "10.0.0.0/24"
}

variable "private_subnets" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  type = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}
