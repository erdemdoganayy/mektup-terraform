variable "aws_access_key" {
  default = ""
}
variable "aws_secret_key" {
  default = ""
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "public-subnet-cidr" {
  default = "10.0.1.0/24"
}
variable "private-subnet-cidr" {
  default = "10.0.2.0/24"
}
variable "mektup-route-table-public" {
  default = "0.0.0.0/0"
}
