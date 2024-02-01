variable "vpc-name" {
  description = "Your vpc name"
  type        = string
  default = "liorm-portfolio"
}

variable "availability_zone" {
  description = "Availability zone list"
  type        = list
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "az_name" {
  description = "Availability zone name list"
  type        = list
  default = ["liorm-us-east-1a", "liorm-us-east-1b", "liorm-us-east-1c"]
}
