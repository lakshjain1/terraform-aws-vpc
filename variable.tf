# not giving any value forcing user to provide value
variable "cidr_block" {
  #default     = ["10.0.0.0/16"]
}


variable "enable_dns_hostnames" {
  default     = true
}

variable "enable_dns_support" {
  default     = true
}

# if we leave it blank it's Mandatory to put by user
variable "project_name" {
  
}

#if we put default it's become optional
variable "common_tags" {
  default = {}
}

variable "vpc_tags" {
  default = {}
}

variable "igw_tags" {
  default = {}
}

variable "public_subnet_cidr" {
  type = list
  validation {
    condition = length(var.public_subnet_cidr) == 2
    error_message = "please provide 2 subnet"
  }
}

variable "private_subnet_cidr" {
  type = list
  validation {
    condition = length(var.private_subnet_cidr) == 2
    error_message = "please provide 2 subnet"
  }
}