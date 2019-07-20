variable "region" {
  description = "AWS Region"
  type = "string"
}

variable "availability_zone" {
  description = "AWS Availability Zone"
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

variable "id" {
  description = "ID of the stark node in the list of nodes"
  type = "string"
}

variable "nightking_hostname" {
  description = "Nightking hostname"
  type = "string"
}

variable "nightking_ip" {
  description = "Nightking IP"
  type = "string"
}

variable experiments {
  description = "Experiment name"
  type = "string"
}

variable telegraf {
  description = "Telegraf InfluxDB password"
  type = "string"
}

variable cacert {
  description = "Nightking CA certificate"
  type = "string"
}

variable ami_owner {
  description = "Owner of the AMI to launch"
  type = "string"
}

variable ami_name {
  description = "Name of the AMI to launch"
  type = "string"
}
