# Auto fill parameters for DEV

# File can be names as:
# terraform.tfvars
# prod.auto.tfvars
# dev.auto.tfvars

region                     = "eu-west-1"
instance_type              = "t3.micro"
enable_detailed_monitoring = false
allow_ports                = ["80", "443", "22", "8080"]
default_tags = {
    Owner       = "leawn"
    Project     = "Phoenix"
    CostCenter  = "12345"
    Environment = "development"
  }