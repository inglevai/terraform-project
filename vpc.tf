# VPC for Application
# https://www.terraform.io/docs/providers/aws/r/vpc.html
resource "aws_vpc" "tf_vai_vpc" {
    cidr_block = "${var.vpc_cidr}"
    tags = {
        Name = "Tf_Vai_VPC"
  }
}

# Create Internet Gateway and attach it to tf_vai_vpc
# Provides a resource to create a VPC Internet Gateway.
# https://www.terraform.io/docs/providers/aws/r/internet_gateway.html

resource "aws_internet_gateway" "tf_vai_igw" {
    vpc_id = "${aws_vpc.tf_vai_vpc.id}"
    tags = {
        Name = "Tf-Vai-IGW"
  }
}


# Build subnet for VPC
#https://www.terraform.io/docs/providers/aws/r/subnet.html

resource "aws_subnet" "public" {
    count = "${length(var.subnets_cidr)}"
    vpc_id     = "${aws_vpc.tf_vai_vpc.id}"
    availability_zone = "${element(var.aws_azs,count.index)}"
    cidr_block = "${element(var.subnet_cidr,count.index)}"
    map_public_ip_on_launch = true
    tags = {
        Name = "tf-vai-public_subnet-${count.index +1}"
  }  
}

# Create Route table, attach IGW and associate with public subnets
# https://www.terraform.io/docs/providers/aws/r/route_table.html

resource "aws_route_table" "tf_public_rt" {
    vpc_id = "${aws_vpc.tf_vai_vpc.id}"
        route {
            cidr_block = "0.0.0.0/0"
            gateway_id = "${aws_internet_gateway.tf_vai_igw.id}"
    }

        tags = {
            Name = "TfPublicRT"
        }

}

# Attach route table with public subnet 
# https://www.terraform.io/docs/providers/aws/r/route_table_association.html

resource "aws_route_table_association" "a" {
    count = "${length(var.subnets_cidr)}"
    subnet_id      = "${element(aws_subnet.public.*.id)}"
    route_table_id = "${aws_route_table.tf_public_rt.id}"
}
