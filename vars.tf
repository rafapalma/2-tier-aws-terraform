variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
    default = "us-east-1"
}

# This AMI map is used to deploy the Jump Host Server
variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-02fe94dee086c0c37"
  }
}

variable "web_ports" {
    default = ["80"]  
}

variable "web_ports_ssl" {
    default = ["80", "443"]
}

variable "admin_ports" {
    default = ["22"]  
}

# White-list for Inbound connections to access the Jump Host
# The map is composed by the port and cidr block
variable "allow_list" {
    type = map
    default = {
        "Admin1" = ["22", ["<YOU-ISP-IP-HERE>/32"]]
        "Admin2" = ["22", ["<YOU-ISP-IP-HERE>/32"]]
    }
}

variable "prefix" {
    default = "stg"
}