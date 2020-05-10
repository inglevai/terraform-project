# Creating new key pare while launching instance
#        1. Generate Public and Private keys

resource "aws_key_pair" "tf_demo" {
  key_name = "tf_demo"
  public_key = "${file("tf-demo.pub")}"
}

resource "aws_instance" "terraform-ec2" {
  count         = "${var.instance_count}"
  ami           = "${lookup(var.ami,var.aws_region)}"
  instance_type = "${var.instance_type}"
  key_name      = "${aws_key_pair.tf_demo.key_name}"
  user_data     = "${file(install_httpd.sh)}"

  tags = {
    Name     = "${element(var.instance_tags,count.index)}"
    location = "mumbai"
  }
}