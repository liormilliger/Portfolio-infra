variable "HOME_IP" {
  description = "IP address at home"
  type        = string
  default     = "93.172.15.217/32"
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

variable "vpc" {
  type        = string
  description = "vpc liorm-portfolio"
}