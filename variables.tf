variable "cidr_block" {
  type = map
  default = {
    "vpc_cidr" = "10.22.0.0/23"
    "sn1" = "10.22.0.0/26"
    "sn2" = "10.22.0.64/26"
    "sn3" = "10.22.0.128/26"
    "sn4" = "10.22.0.192/26"
    "any_cidr" = "0.0.0.0/0"
  }
}

variable "az" {
    type = list
    default = ["ap-south-1a", "ap-south-1b"]
}

variable "tag_name" {
    type = list
    default = ["public", "private", "demo" ,"bastion", "server", "nat"]
}

variable "instancetype" {
  type = list
  default = ["t2.micro"]
}

variable "key_pair" {
  default = "project_terraform"
}

variable "sg_type" {
  type = list
  default = ["ingress", "egress"]
}