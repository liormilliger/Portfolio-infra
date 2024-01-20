variable "AMI" {
  type        = string
  description = "Image for ubuntu instance"
  default     = "ami-0c7217cdde317cfec"
}

variable "TYPE" {
  type        = string
  description = "Instance type"
  default     = "t3a.small"
}
variable "HOME_IP" {
  description = "IP address at home"
  type        = string
  default = "85.64.145.23/32"
  # default     = "93.172.15.217/32"
}

variable "KARMI_IP" {
  description = "IP at KARMI house"
  type        = string
  default     = "147.235.214.133/32"
}

variable "Develeap_IP" {
  description = "IP at Develeap Offices"
  type        = string
  default     = "11.22.33.44/32"
}

variable "REGION" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}