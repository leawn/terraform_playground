variable "region" {
  description = "Please enter AWS region to deploy server"
  type        = string
  default     = "eu-west-1"
}

variable "instance_type" {
  description = "Please enter AWS instance type"
  type        = string
  default     = "t3.micro"
}

variable "allow_ports" {
  description = "List of ports to open for server"
  type        = list(string)
  default     = ["80", "443", "22", "8080"]
}

variable "detailed_monitoring" {
  description = "Enable monitoring? (true/false)"
  type        = bool
  default     = true
}

variable "default_tags" {
  description = "Common tags to apply to all resources"
  type        = map(any)
  default = {
    Owner       = "leawn"
    Project     = "Phoenix"
    CostCenter  = "12345"
    Environment = "development"
  }
}