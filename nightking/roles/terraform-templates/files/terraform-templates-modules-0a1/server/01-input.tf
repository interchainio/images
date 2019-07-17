variable "region" {
  description = "AWS Region"
  type = "string"
}

variable "availability_zone" {
  description = "AWS Availability Zone"
  type = "string"
}

variable "ami" {
  description = "AWS EC2 AMI"
  type = "string"
}

variable "instance_type" {
  description = "AWS EC2 instance type"
  type = "string"
}

variable "role" {
  description = "GoT role for the server: stark/whitewalker"
  type = "string"
}

variable "volume_size" {
  description = "Server disk size"
  type = "string"
  default = "40"
}
