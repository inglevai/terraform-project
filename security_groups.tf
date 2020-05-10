# https://www.terraform.io/docs/providers/aws/r/security_group.html

resource "aws_security_groups" "webserver" {
    name        = "allow_http"
    description = "Allow http inbound traffic"
    vpc_id      = "${aws_vpc.tf_vai_vpc.id}"

    ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
      
}
