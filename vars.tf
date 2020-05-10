#Create varible - this is used to for agile changes, instead of 
#changing whole environemnt you can just change varibles
# Notes - Terraform support different types of variables 
#1.List
#2.String
#3.Map

variable "ami" {
    type = "map"
    default =   {
      ap-south-1 = "ami-0470e33cd681b2476"
      us-east-1 = "ami-0323c3dd2da7fb37d"  
      } 
 }

 variable "instance_type" {
  default = "t2.micro"
 }

variable "aws_region" {
  default = "ap-south-1"
}

variable "instance_count" {
    default = "2"
}

variable "instance_tags" {
    type = "list"
    default = ["Terraform-1", "Terraform-2", "Terraform-3"]
}
variable "vpc_cidr" {
  default = "10.20.0.0/16"
}

variable "subnets_cidr" {
  type = "list"
  default = ["10.20.1.0/24","10.20.2.0/24"]
}

variable "aws_azs" {
  type = "list"
  default = ["ap-south-1a","ap-south-1b"]
}

variable "weberver_ami" {
  default = "ami-0470e33cd681b2476"
}
